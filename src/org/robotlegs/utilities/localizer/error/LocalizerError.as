package org.robotlegs.utilities.localizer.error
{
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class LocalizerError extends Error
	{
		/**
		 * 
		 * 
		 * @param message
		 * @param id
		 */
		public function LocalizerError( message: * = '', id: * = 0 )
		{
			super( message, id );
		}
	}
}