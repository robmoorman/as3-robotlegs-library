package org.robotlegs.utilities.layers.error
{
	/**
	 * Custom error <code>Class</code> for an <code>AssetLoader</code>.
	 * 
	 * @author r.moorman
	 */
	public class LayersError extends Error
	{
		/**
		 * @inheritDoc
		 */
		public function LayersError( message: * = '', id: * = 0 )
		{
			super( message, id );
		}
	}
}