package org.robotlegs.utilities.navigator.error
{
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class NavigatorError extends Error
	{
		/**
		 * 
		 * 
		 * @param message
		 * @param id
		 */
		public function NavigatorError( message: * = '', id: * = 0 )
		{
			super( message, id );
		}
	}
}