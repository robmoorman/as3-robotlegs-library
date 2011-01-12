package org.robotlegs.utilities.assetloader.patterns.asset.type
{
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;

	/**
	 * 
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
		 * 
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
		public function XMLAsset( id: String, url: String )
		{
			super( id, url );
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