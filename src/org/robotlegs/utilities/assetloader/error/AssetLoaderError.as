package org.robotlegs.utilities.assetloader.error
{
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class AssetLoaderError extends Error
	{
		/**
		 * 
		 * 
		 * @param message
		 * @param id
		 */
		public function AssetLoaderError( message: * = '', id: * = 0 )
		{
			super( message, id );
		}
	}
}