package org.robotlegs.utilities.localizer.core
{
	import org.robotlegs.utilities.localizer.patterns.locale.ILocale;
	
	/**
	 * Abstract <code>ILocalizer</code> interface.
	 * 
	 * @author r.moorman
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/localizer
	 */
	public interface ILocalizer
	{
		/**
		 * 
		 */
		function get iterateObjectsInCustomData(): Boolean;
		
		/**
		 * @private
		 */
		function set iterateObjectsInCustomData( value: Boolean ): void;
		
		/**
		 * 
		 * 
		 * @param code
		 */
		function localize( code: String ): void;
		
		/**
		 * 
		 * 
		 * @param data
		 * @param prefix
		 */
		function localizeCustomData( data: Object, prefix: String = '' ): void;
		
		/**
		 * 
		 * 
		 * @param code
		 * @param data
		 */
		function addLocale( code: String, data: Object ): void;
		
		/**
		 * 
		 * 
		 * @param code
		 * @return
		 */
		function hasLocale( code: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param code
		 * @return
		 */
		function getLocale( code: String ): ILocale;
		
		/**
		 * 
		 * 
		 * @param code
		 * @return
		 */
		function removeLocale( code: String ): ILocale;
	}
}