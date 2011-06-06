package org.robotlegs.utilities.assetloader.utils
{
	import flash.utils.Dictionary;
	
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
		 * @param url The url of the <code>Asset</code>.
		 * @param assetClassMap
		 * @param extension The extension of the file.
		 * @return The type of <code>Asset</code>, default <code>Asset</code>.
		 */
		public static function getAssetClassByExtension( url: String, assetClassMap: Dictionary, extension: String ): Class
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
					var contains: String;
					
					for( contains in assetClassMap ) {
						if( url.indexOf( contains ) != -1 ) {
							assetClass = assetClassMap[ contains ] as Class;
						}
					}
					
					if( !assetClass ) {
						assetClass = Asset;
					}
					break;
			}
			
			return assetClass;
		}
	}
}