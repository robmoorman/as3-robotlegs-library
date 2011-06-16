package org.robotlegs.utilities.assetloader.patterns.group
{
	import flash.events.EventDispatcher;
	
	import org.robotlegs.utilities.assetloader.core.AssetLoaderState;
	import org.robotlegs.utilities.assetloader.events.AssetLoaderEvent;
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	
	/**
	 * Abstract implementation of <code>IGroup</code>.
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
		 * <p>At this point the state of the <code>Group</code> is <code>INITIALIZING</code>.</p>
		 * 
		 * @param id The id of the <code>Group</code>.
		 * @param assets The assets of the <code>Group</code>.
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
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.getAsset()
		 */
		public function getAsset( id: String ): IAsset
		{
			var asset: IAsset;
			
			for each( asset in _assets ) {
				if( asset.id === id ) {
					return asset;
				}
			}
			
			return null;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.group.IGroup.getAssetByUrl()
		 */
		public function getAssetByUrl( url: String ): IAsset
		{
			var asset: IAsset;
			
			for each( asset in _assets ) {
				if( asset.url.indexOf( url ) != -1 ) {
					return asset;
				}
			}
			
			return null;
		}
		
		/**
		 * Load the next <code>Asset</code> in the queue.
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
		 * Change the state of the <code>Group</code>.
		 * 
		 * @param state The upcoming state of the <code>Group</code>.
		 */
		final protected function setState( state: String ): void
		{
			_state = state;
		}
		
		/**
		 * Handle <code>AssetLoaderEvents</code> during the load process of the current <code>Asset</code>.
		 * 
		 * @param evt The <code>AssetLoaderEvent</code> that triggered this method (<code>AssetLoaderEvent.ASSET_COMPLETE</code>, <code>AssetLoaderEvent.ASSET_PROGRESS</code> and <code>AssetLoaderEvent.ASSET_ERROR</code>).
		 */
		final protected function onAssetProcess( event: AssetLoaderEvent ): void
		{
			event.group = this;
			
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
		 * Get the total count of loaded <code>Assets</code> in the <code>Group</code>.
		 * 
		 * @return The total count of loaded <code>Assets</code> in the <code>Group</code>.
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
		 * Determine if all total bytes of the <code>Assets</code> are defined in the <code>Group</code>.
		 * 
		 * @return <code>True</code> or <code>False</code>.
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