package org.robotlegs.utilities.assetloader.patterns.asset.type
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class DisplayObjectAsset extends Asset
	{
		/**
		 * @iheritDoc
		 */
		override public function set url( value: String ): void {
			super.url = value;
			
			_loader = new Loader;
 		}
		
		/**
		 * 
		 */
		public function get displayObject(): DisplayObject {
			return _displayObject;
		}
		
		/**
		 * @private
		 */
		private var _displayObject: DisplayObject;
		
		/**
		 * @iheritDoc
		 */
		public function DisplayObjectAsset( id: String, url: String )
		{
			super( id, url );
		}
		
		/**
		 * @iheritDoc
		 */
		override protected function onComplete( evt: Event ): void
		{
			super.onComplete( evt );
			
			_displayObject = evt.target.content as DisplayObject;
		}
	}
}