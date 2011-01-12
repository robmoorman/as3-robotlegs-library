package org.robotlegs.utilities.assetloader.patterns.asset
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.utilities.assetloader.core.AssetLoaderState;
	import org.robotlegs.utilities.assetloader.error.AssetLoaderError;
	import org.robotlegs.utilities.assetloader.events.AssetLoaderEvent;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class Asset extends EventDispatcher implements IAsset
	{
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.id
		 */
		public function get id(): String {
			return _id;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.url
		 */
		public function get url(): String {
			return _url;
		}
		
		/**
		 * @private
		 */
		public function set url( value: String ): void {
			_url = value;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.closure
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
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.state
		 */
		public function get state(): String {
			return _state;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.data
		 */
		public function get data(): Object {
			return _data;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.bytesLoaded
		 */
		public function get bytesLoaded(): uint {
			return _bytesLoaded;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.bytesTotal
		 */
		public function get bytesTotal(): uint {
			return _bytesTotal;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.percentage
		 */
		public function get percentage(): Number {
			return ( _bytesLoaded / _bytesTotal ) * 100;
		}
		
		/**
		 * @private
		 */
		protected var _id: String;
		
		/**
		 * @private
		 */
		protected var _url: String;
		
		/**
		 * @private
		 */
		protected var _closure: Function;
		
		/**
		 * @private
		 */
		protected var _loader: Object;
		
		/**
		 * @private
		 */
		protected var _state: String;
		
		/**
		 * @private
		 */
		protected var _data: Object;
		
		/**
		 * @private
		 */
		protected var _bytesLoaded: uint;
		
		/**
		 * @private
		 */
		protected var _bytesTotal: uint;
		
		/**
		 * @private
		 */
		protected var _onComplete: Function;
		
		/**
		 * @private
		 */
		protected var _onProgress: Function;
		
		/**
		 * @private
		 */
		protected var _onError: Function;
		
		/**
		 * Constructor.
		 * 
		 * @param id
		 * @param url
		 */
		public function Asset( id: String, url: String )
		{
			setState( AssetLoaderState.INITIALIZING );
			
			_id = id;
			_bytesLoaded = 0;
			_bytesTotal = 0;
			
			this.url = url;
			
			if( !_loader )
				_loader = new URLLoader;
			
			defineEventModel();
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.load()
		 */
		public function load(): void
		{
			setState( AssetLoaderState.LOADING );
			
			if( _closure != null ) {
				var type: String;
				
				for each( type in [ AssetLoaderEvent.ASSET_COMPLETE, AssetLoaderEvent.ASSET_PROGRESS, AssetLoaderEvent.ASSET_ERROR ] )
					addEventListener( type, _closure );
			}
			
			var request: URLRequest = new URLRequest( _url );
			
			_loader.load( request );
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.dispose()
		 */
		public function dispose(): void
		{
			if( _closure != null ) {
				var type: String;
				
				for each( type in [ AssetLoaderEvent.ASSET_COMPLETE, AssetLoaderEvent.ASSET_PROGRESS, AssetLoaderEvent.ASSET_ERROR ] )
					removeEventListener( type, _closure );
			}
			
			undefineEventModel();
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.setOnComplete()
		 */
		public function setOnComplete( value: Function ): void
		{
			_onComplete = value;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.setOnProgress()
		 */
		public function setOnProgress( value: Function ): void
		{
			_onProgress = value;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.patterns.asset.IAsset.setOnError()
		 */
		public function setOnError( value: Function ): void
		{
			_onError = value;
		}
		
		/**
		 * 
		 * 
		 * @throws AssetLoaderError
		 */
		protected function defineEventModel(): void
		{
			if( !_loader )
				throw new AssetLoaderError( 'No loader instance instantiated, unable to define the Event model' );
			else {
				with( _loader is Loader ? Loader( _loader ).contentLoaderInfo : _loader ) {
					addEventListener( Event.COMPLETE, onAssetProcess );
					addEventListener( ProgressEvent.PROGRESS, onAssetProcess );
					addEventListener( IOErrorEvent.IO_ERROR, onAssetProcess );
				}
			}
		}
		
		/**
		 * 
		 */
		protected function undefineEventModel(): void
		{
			with( _loader is Loader ? Loader( _loader ).contentLoaderInfo : _loader ) {
				removeEventListener( Event.COMPLETE, onAssetProcess );
				removeEventListener( ProgressEvent.PROGRESS, onAssetProcess );
				removeEventListener( IOErrorEvent.IO_ERROR, onAssetProcess );
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
		 * @param evt
		 */
		protected function onComplete( evt: Event ): void
		{
			_data = _loader is Loader ? evt.target.content : _loader is Sound ? null : evt.target.data;
		}
		
		/**
		 * 
		 * 
		 * @param evt
		 */
		final protected function onAssetProcess( evt: Event ): void
		{
			switch( evt.type ) {
				case Event.COMPLETE:
					setState( AssetLoaderState.LOADED );
					
					onComplete( evt );
					
					if( _closure != null )
						dispatchEvent( new AssetLoaderEvent( AssetLoaderEvent.ASSET_COMPLETE, this ));
					
					dispose();
					break;
				case ProgressEvent.PROGRESS:
					_bytesLoaded = ProgressEvent( evt ).bytesLoaded;
					_bytesTotal = ProgressEvent( evt ).bytesTotal;
					
					if( _closure != null )
						dispatchEvent( new AssetLoaderEvent( AssetLoaderEvent.ASSET_PROGRESS, this ));
					break;
				case IOErrorEvent.IO_ERROR:
					setState( AssetLoaderState.FAILED );
					
					if( _closure != null )
						dispatchEvent( new AssetLoaderEvent( AssetLoaderEvent.ASSET_ERROR, this ));
					
					dispose();
					break;
			}
		}
	}
}