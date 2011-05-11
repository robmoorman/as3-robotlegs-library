package org.robotlegs.utilities.assetloader.patterns.group
{
	import flash.events.EventDispatcher;
	
	import org.robotlegs.utilities.assetloader.core.AssetLoaderState;
	import org.robotlegs.utilities.assetloader.events.AssetLoaderEvent;
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class Group extends EventDispatcher implements IGroup
	{
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.id
		 */
		public function get id(): String {
			return _id;
		}
		
		/**
		 * @private
		 */
		public function set id( value: String ): void {
			_id = value;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.assets
		 */
		public function get assets(): Vector.<IAsset> {
			return _assets;
		}
		
		/**
		 * @private
		 */
		public function set assets( value: Vector.<IAsset> ): void {
			_assets = value;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.maxConnections
		 */
		public function get maxConnections(): int {
			return _maxConnections;
		}
		
		/**
		 * @private
		 */
		public function set maxConnections( value: int ): void {
			_maxConnections = value;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.closure
		 */
		public function get closure(): Function {
			return _closure;
		}
		
		/**
		 * @private
		 */
		public function set closure( value: Function ): void {
			_closure = value;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.state
		 */
		public function get state(): String {
			return _state;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.bytesLoaded
		 */
		public function get bytesLoaded(): uint {
			var asset: IAsset;
			var bytes: uint =  0;
			
			for each( asset in assets ) {
				bytes += asset.bytesLoaded;
			}
			
			return bytes;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.bytesTotal
		 */
		public function get bytesTotal(): uint {
			var asset: IAsset;
			var bytes: uint =  0;
			
			for each( asset in assets ) {
				bytes += asset.bytesTotal;
			}
			
			return bytes;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.percentage
		 */
		public function get percentage(): Number {
			if( assetFileSizesDefined()) {
				return ( bytesLoaded / bytesTotal ) * 100;
			}
			else {
				return ( getLoadedAssets() / assets.length ) * 100;
			}
		}
		
		/**
		 * @private
		 */
		protected var _id: String;
		
		/**
		 * @private
		 */
		protected var _assets: Vector.<IAsset>;
		
		/**
		 * @private
		 */
		protected var _maxConnections: int;
		
		/**
		 * @private
		 */
		protected var _closure: Function;
		
		/**
		 * @private
		 */
		protected var _queuedAsset: int;
		
		/**
		 * @private
		 */
		protected var _state: String;
		
		/**
		 * Constructor.
		 * 
		 * @param id
		 * @param assets
		 */
		public function Group( id: String, assets: Vector.<IAsset> )
		{
			setState( AssetLoaderState.INITIALIZING );
			
			this.id = id;
			this.assets = assets;
			this.maxConnections = 1;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.load()
		 */
		public function load(): void
		{
			setState( AssetLoaderState.LOADING );
			
			if( _closure != null ) {
				var type: String;
				
				for each( type in [ AssetLoaderEvent.ASSET_COMPLETE, AssetLoaderEvent.ASSET_PROGRESS, AssetLoaderEvent.ASSET_ERROR, AssetLoaderEvent.GROUP_COMPLETE, AssetLoaderEvent.GROUP_PROGRESS, AssetLoaderEvent.GROUP_ERROR ] )
					addEventListener( type, _closure );
			}
			
			loadQueuedAsset();
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.dispose()
		 */
		public function dispose(): void
		{
			if( _closure != null ) {
				var type: String;
				
				for each( type in [ AssetLoaderEvent.ASSET_COMPLETE, AssetLoaderEvent.ASSET_PROGRESS, AssetLoaderEvent.ASSET_ERROR, AssetLoaderEvent.GROUP_COMPLETE, AssetLoaderEvent.GROUP_PROGRESS, AssetLoaderEvent.GROUP_ERROR ] )
					removeEventListener( type, _closure );
			}
			
			var asset: IAsset;
			
			for each( asset in _assets )
				asset.dispose();
			
			_assets = null;
		}
		
		/**
		 * 
		 */
		protected function loadQueuedAsset(): void
		{
			if( _maxConnections ) {
				_maxConnections--;
				
				var asset: IAsset = _assets[ _queuedAsset++ ];
				
				asset.closure = onAssetProcess;
				asset.load();
			}
		}
		
		/**
		 * 
		 * 
		 * @param state
		 */
		final protected function setState( state: String ): void
		{
			_state = state;
		}
		
		/**
		 * 
		 * 
		 * @param event
		 */
		final protected function onAssetProcess( event: AssetLoaderEvent ): void
		{
			switch( event.type ) {
				case AssetLoaderEvent.ASSET_COMPLETE:
					_maxConnections++;
					
					if( _closure != null ) {
						dispatchEvent( event );
						
						var asset: IAsset;
						var completed: Boolean = true;
						
						for each( asset in _assets ) {
							if( asset.state != AssetLoaderState.LOADED ) {
								completed = false;
								
								break;
							}
						}
						
						if( completed )
							dispatchEvent( new AssetLoaderEvent( AssetLoaderEvent.GROUP_COMPLETE, event.asset, this ));
						else
							loadQueuedAsset();
					}
					break;
				case AssetLoaderEvent.ASSET_PROGRESS:
					if( _closure != null ) {
						dispatchEvent( event );
						dispatchEvent( new AssetLoaderEvent( AssetLoaderEvent.GROUP_PROGRESS, event.asset, this ));
					}
					break;
				case AssetLoaderEvent.ASSET_ERROR:
					setState( AssetLoaderState.FAILED );
					
					if( _closure != null ) {
						dispatchEvent( event );
						dispatchEvent( new AssetLoaderEvent( AssetLoaderEvent.GROUP_ERROR, event.asset, this ));
					}
					break;
			}
		}
		
		/**
		 * 
		 * 
		 * @return  
		 */
		final private function getLoadedAssets(): int
		{
			var i: int = 0;
			var asset: IAsset;
			
			for each( asset in assets ) {
				if( asset.state === AssetLoaderState.LOADED ) {
					i++;
				}
			}
			
			return i;
		}
		
		/**
		 * 
		 * 
		 * @return  
		 */
		final private function assetFileSizesDefined(): Boolean
		{
			var asset: IAsset;
			
			for each( asset in assets ) {
				if( asset.bytesTotal == 0 ) {
					return false;
				}
			}
			
			return true;
		}
	}
}