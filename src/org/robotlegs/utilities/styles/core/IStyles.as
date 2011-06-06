package org.robotlegs.utilities.styles.core
{
	import flash.text.StyleSheet;

	/**
	 * The interface definition for <code>Styles</code>.
	 * 
	 * @author r.moorman
	 * https://github.com/moorinteractive/as3-robotlegs-library/wiki/styles
	 */
	public interface IStyles
	{
		/**
		 * 
		 */
		function get styleSheet(): StyleSheet;
		
		/**
		 * 
		 * 
		 * @param styleSheet
		 */
		function addStyle( styleSheet: StyleSheet ): void
		
		/**
		 * 
		 * 
		 * @param url
		 * @param closure
		 */
		function loadStyle( url: String, closure: Function = null ): void;
	}
}