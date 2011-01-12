package org.robotlegs.utilities.router.patterns.pattern
{
	/**
	 * Abstract <code>IPattern</code> interface.
	 * 
	 * @author r.moorman
	 */
	public interface IPattern
	{
		/**
		 * 
		 * 
		 * @return 
		 */
		function get name(): String;
		
		/**
		 * 
		 * 
		 * @return 
		 */
		function get value(): String;
		
		/**
		 * 
		 * 
		 * @param pathName
		 * @return 
		 */
		function match( pathName: String ): Boolean;
	}
}