package org.robotlegs.utilities.router.error
{
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class RouterError extends Error
	{
		/**
		 * 
		 * 
		 * @param message
		 * @param id
		 */
		public function RouterError( message: * = '', id: * = 0 )
		{
			super( message, id );
		}
	}
}