package org.robotlegs.utilities.assetloader.utils
{
	import org.robotlegs.utilities.assetloader.patterns.asset.Asset;
	import org.robotlegs.utilities.assetloader.patterns.asset.type.BitmapAsset;
	import org.robotlegs.utilities.assetloader.patterns.asset.type.CSSAsset;
	import org.robotlegs.utilities.assetloader.patterns.asset.type.DisplayObjectAsset;
	import org.robotlegs.utilities.assetloader.patterns.asset.type.SoundAsset;
	import org.robotlegs.utilities.assetloader.patterns.asset.type.XMLAsset;

	/**
	 * Utilities for <code>Asset</code> related functionalities.
	 * 
	 * @author r.moorman
	 */
	public class AssetUtil
	{
		/**
		 * Get the type of <code>Asset</code> depending on the file extension.
		 * 
		 * @param extension The extension of the file.
		 * @return The type of <code>Asset</code>, default <code>Asset</code>.
		 */
		public static function getAssetClassByExtension( extension: String ): Class
		{
			var assetClass: Class;
			
			switch( extension ) {
				case 'png':
				case 'gif':
				case 'jpg':
				case 'jpeg':
					assetClass = BitmapAsset;
					break;
				case 'swf':
					assetClass = DisplayObjectAsset;
					break;
				case 'mp3':
				case 'wav':
				case 'aif':
					assetClass = SoundAsset;
					break;
				case 'css':
					assetClass = CSSAsset;
					break;
				case 'xml':
					assetClass = XMLAsset;
					break;
				default:
					assetClass = Asset;
					break;
			}
			
			return assetClass;
		}
	}
}