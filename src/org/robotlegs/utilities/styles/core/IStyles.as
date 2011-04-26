package org.robotlegs.utilities.styles.core
{
	import flash.text.StyleSheet;

	/**
	 * 
	 * 
	 * @author r.moorman
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