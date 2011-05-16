package org.robotlegs.utilities.localizer.patterns.locale
{
	/**
	 * The interface definition for an <code>Locale</code>.
	 * 
	 * @author r.moorman
	 */
	public interface ILocale
	{
		/**
		 * The code of the <code>Locale</code>.
		 */
		function get code(): String;
		
		/**
		 * The data to be localized.
		 */
		function get data(): Object;
	}
}