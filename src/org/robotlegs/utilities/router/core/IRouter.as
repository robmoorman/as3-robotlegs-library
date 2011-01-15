package org.robotlegs.utilities.router.core
{
	import org.robotlegs.utilities.router.patterns.route.Route;

	/**
	 * Abstract <code>IRouter</code> interface.
	 * 
	 * @author r.moorman
	 */
	public interface IRouter
	{
		/**
		 * 
		 * 
		 * @return 
		 */
		function get active(): Boolean;
		
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