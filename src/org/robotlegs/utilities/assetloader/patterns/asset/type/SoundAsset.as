package org.robotlegs.utilities.assetloader.patterns.asset.type
{
	import flash.media.Sound;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;
	import flash.system.LoaderContext;

	/**
	 * Automatic assigned type of <code>Asset</code> for loading <code>Bitmaps</code> (mp3, wav, aif).
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
		 * The loaded <code>Sound</code>.
		 */
		public function get sound(): Sound {
			return _loader as Sound;
		}
		
		/**
		 * @iheritDoc
		 */
		public function SoundAsset( id: String, url: String, loaderContext: LoaderContext = null )
		{
			super( id, url, loaderContext );
		}
	}
}