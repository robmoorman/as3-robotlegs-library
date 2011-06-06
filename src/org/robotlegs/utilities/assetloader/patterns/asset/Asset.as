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
	import flash.system.LoaderContext;
	
	import org.robotlegs.utilities.assetloader.core.AssetLoaderState;
	import org.robotlegs.utilities.assetloader.error.AssetLoaderError;
	import org.robotlegs.utilities.assetloader.events.AssetLoaderEvent;

	/**
	 * Abstract implementation of <code>IAsset</code>.
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
		 * @private
		 */
		protected var _loaderContext: LoaderContext;
		
		/**
		 * Constructor.
		 * 
		 * <p>At this point the state of the <code>Asset</code> is <code>INITIALIZING</code>.</p>
		 * 
		 * @param id The id of the <code>Asset</code>.
		 * @param url The url of the <code>Asset</code>.
		 */
		public function Asset( id: String, url: String, loaderContext: LoaderContext = null )
		{
			setState( AssetLoaderState.INITIALIZING );
			
			_id = id;
			_loaderContext = loaderContext;
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
			
			if( _loader is Loader ) {
				_loader.load( request, _loaderContext );
			}
			else {
				_loader.load( request );
			}
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
		 * Map eventListeners of the <code>Asset</code>.
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
		 * Unmap eventListeners of the <code>Asset</code>.
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
		 * Change the state of the <code>Asset</code>.
		 * 
		 * @param state The upcoming state of the <code>Asset</code>.
		 */
		final protected function setState( state: String ): void
		{
			_state = state;
		}
		
		/**
		 * Abstract method to handle the loaded <code>Asset</code>.
		 * 
		 * @param evt The <code>Event</code> that triggered this method (<code>Event.COMPLETE</code>).
		 */
		protected function onComplete( evt: Event ): void
		{
			_data = _loader is Loader ? evt.target.content : _loader is Sound ? null : evt.target.data;
		}
		
		/**
		 * Handle <code>Events</code> during the load process of the <code>Asset</code>.
		 * 
		 * @param evt The <code>Event</code> that triggered this method (<code>Event.COMPLETE</code>, <code>ProgressEvent.PROGRESS</code> and <code>IOErrorEvent.IO_ERROR</code>).
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