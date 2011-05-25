package org.robotlegs.utilities.navigator.patterns.page
{
	import flash.display.DisplayObject;

	/**
	 * Abstract <code>IPage</code> interface.
	 * 
	 * @author r.moorman
	 */
	public interface IPage
	{
		/**
		 * 
		 */
		function get name(): String;
		
		/**
		 * 
		 */
		function get content(): DisplayObject;
		
		/**
		 * 
		 */
		function reset(): void;
	}
}