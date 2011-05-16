package org.robotlegs.utilities.assetloader.patterns.asset.type
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.text.StyleSheet;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;

	/**
	 * Automatic assigned type of <code>Asset</code> for loading stylesheets (css).
	 * 
	 * @author r.moorman
	 */
	public class CSSAsset extends Asset
	{
		/**
		 * @iheritDoc
		 */
		override public function set url( value: String ): void {
			super.url = value;
			
			_loader = new URLLoader;
		}
		
		/**
		 * The loaded <code>Stylesheet</code>.
		 */
		public function get styleSheet(): StyleSheet {
			return _styleSheet;
		}
		
		/**
		 * @private
		 */
		private var _styleSheet: StyleSheet;
		
		/**
		 * @iheritDoc
		 */
		public function CSSAsset( id: String, url: String )
		{
			super( id, url );
		}
		
		/**
		 * @iheritDoc
		 */
		override protected function onComplete( evt: Event ): void
		{
			super.onComplete( evt );
			
			_styleSheet = new StyleSheet;
			_styleSheet.parseCSS( evt.target.data.toString());
		}
	}
}