package org.robotlegs.utilities.router.core
{
	import org.robotlegs.utilities.router.patterns.route.Route;

	/**
	 * Abstract <code>IRouter</code> interface.
	 * 
	 * @author r.moorman
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/router
	 */
	public interface IRouter
	{
		/**
		 * 
		 */
		function get active(): Boolean;
		
		/**
		 * 
		 */
		function get pathNames(): Array;
		
		/**
		 * 
		 * 
		 * @param checkRoutes
		 */
		function activate( checkRoutes: Boolean = true ): void;
		
		/**
		 * 
		 */
		function deactivate(): void;
		
		/**
		 * 
		 * 
		 * @param type
		 * @param commandClass
		 * @return 
		 */
		function addRoute( type: String, commandClass: Class = null ): Route;
		
		/**
		 * 
		 * 
		 * @param type
		 * @param commandClass
		 * @return 
		 */
		function removeRoute( type: String, commandClass: Class ): void;
		
		/**
		 * 
		 * 
		 * @param value
		 */
		function changeAddress( value: String ): void;
		
		/**
		 * 
		 * 
		 * @param value
		 */
		function changeAddressOnly( value: String ): void;
		
		/**
		 * Change the title of your browser.
		 * 
		 * @param value
		 */
		function changeBrowserTitle( value: String ): void;
	}
}