package org.robotlegs.utilities.assetloader.patterns.asset.type
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class BitmapAsset extends Asset
	{
		/**
		 * @inheritDoc
		 */
		override public function set url( value: String ): void {
			super.url = value;
			
			_loader = new Loader;
		}
		
		/**
		 * 
		 */
		public function get bitmap(): Bitmap {
			return _bitmap;
		}
		
		/**
		 * 
		 */
		public function get bitmapData(): BitmapData {
			return _bitmapData;
		}
		
		/**
		 * @private
		 */
		private var _bitmap: Bitmap;
		
		/**
		 * @private
		 */
		private var _bitmapData: BitmapData;
		
		/**
		 * @inheritDoc
		 */
		public function BitmapAsset( id: String, url: String )
		{
			super( id, url );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onComplete( evt: Event ): void
		{
			super.onComplete( evt );
			
			_bitmap = Bitmap( evt.target.content );
			_bitmapData = _bitmap.bitmapData;
		}
	}
}