package org.robotlegs.utilities.localizer.patterns.locale
{
	/**
	 * Abstract implementation of <code>ILocale</code>.
	 * 
	 * @author r.moorman
	 */
	public class Locale implements ILocale
	{
		/**
		 * @copy org.robotlegs.utilities.localizer.patterns.locale.ILocale.code
		 */
		public function get code(): String {
			return _code;
		}
		
		/**
		 * @copy org.robotlegs.utilities.localizer.patterns.locale.ILocale.data
		 */
		public function get data(): Object {
			return _data;
		}
		
		/**
		 * @private
		 */
		private var _code: String;
		
		/**
		 * @private
		 */
		private var _data: Object;
		
		/**
		 * Constructor.
		 * 
		 * @param code The code of the <code>Locale</code>.
		 * @param data The data to be localized.
		 */
		public function Locale( code: String, data: Object )
		{
			_code = code;
			_data = data;
		}
	}
}