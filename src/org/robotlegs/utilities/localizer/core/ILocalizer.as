package org.robotlegs.utilities.localizer.core
{
	import org.robotlegs.utilities.localizer.patterns.locale.ILocale;
	
	/**
	 * The interface definition for <code>Localizer</code>.
	 * 
	 * @author r.moorman
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/localizer
	 */
	public interface ILocalizer
	{
		/**
		 * Localize a <code>Locale</code> by it's code.
		 * 
		 * @param code
		 */
		function localize( code: String ): void;
		
		/**
		 * Localize custom <code>XML</code> or <code>Object</code> data.
		 * 
		 * @param data The data to be localized.
		 * @param prefix Optional prefix of all iterated mappings.
		 */
		function localizeCustomData( data: Object, prefix: String = '' ): void;
		
		/**
		 * 
		 * 
		 * @param code The code of the <code>Locale</code>.
		 * @param data
		 */
		function addLocale( code: String, data: Object ): void;
		
		/**
		 * 
		 * 
		 * @param code The code of the <code>Locale</code>.
		 * @return
		 */
		function hasLocale( code: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param code The code of the <code>Locale</code>.
		 * @return
		 */
		function getLocale( code: String ): ILocale;
		
		/**
		 * 
		 * 
		 * @param code The code of the <code>Locale</code>.
		 * @return
		 */
		function removeLocale( code: String ): ILocale;
	}
}