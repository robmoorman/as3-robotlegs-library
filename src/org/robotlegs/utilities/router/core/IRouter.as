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
		 * @return 
		 */
		function addRoute( type: String ): Route;
		
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
	}
}