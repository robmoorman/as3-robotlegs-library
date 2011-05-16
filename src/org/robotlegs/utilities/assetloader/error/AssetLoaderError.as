package org.robotlegs.utilities.assetloader.error
{
	/**
	 * Custom error <code>Class</code> for an <code>AssetLoader</code>.
	 * 
	 * @author r.moorman
	 */
	public class AssetLoaderError extends Error
	{
		/**
		 * @inheritDoc
		 */
		public function AssetLoaderError( message: * = '', id: * = 0 )
		{
			super( message, id );
		}
	}
}