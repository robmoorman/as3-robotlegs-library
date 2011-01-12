package org.robotlegs.utilities.assetloader.patterns.asset.type
{
	import flash.media.Sound;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class SoundAsset extends Asset
	{
		/**
		 * @iheritDoc
		 */
		override public function set url( value: String ): void {
			super.url = value;
			
			_loader = new Sound;
		}
		
		/**
		 * 
		 */
		public function get sound(): Sound {
			return _loader as Sound;
		}
		
		/**
		 * @iheritDoc
		 */
		public function SoundAsset( id: String, url: String )
		{
			super( id, url );
		}
	}
}