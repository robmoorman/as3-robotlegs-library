package org.robotlegs.utilities.assetloader.patterns.asset.type
{
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;
	import flash.system.LoaderContext;

	/**
	 * Automatic assigned type of <code>Asset</code> for loading <code>Bitmaps</code> (xml).
	 * 
	 * @author r.moorman
	 */
	public class XMLAsset extends Asset
	{
		/**
		 * @iheritDoc
		 */
		override public function set url( value: String ): void {
			super.url = value;
			
			_loader = new URLLoader;
		}
		
		/**
		 * The loaded <code>XML</code>.
		 */
		public function get xml(): XML {
			return _xml;
		}
		
		/**
		 * @private
		 */
		private var _xml: XML;
		
		/**
		 * @iheritDoc
		 */
		public function XMLAsset( id: String, url: String, loaderContext: LoaderContext = null )
		{
			super( id, url, loaderContext );
		}
 		
		/**
		 * @iheritDoc
		 */
		override protected function onComplete( evt: Event ): void
		{
			super.onComplete( evt );
			
			_xml = XML( evt.target.data );
		}
	}
}