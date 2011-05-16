package org.robotlegs.utilities.localizer.core
{
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.utilities.localizer.events.LocalizerEvent;
	import org.robotlegs.utilities.localizer.patterns.locale.ILocale;
	import org.robotlegs.utilities.localizer.patterns.locale.Locale;
	
	/**
	 * This utility allows you to automatically map iterations of <code>XML</code>
	 * or <code>Object</code> data in the <code>Injector</code>.
	 * 
	 * @author r.moorman
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/localizer
	 */
	public class Localizer extends Actor implements ILocalizer
	{
		/**
		 * @private
		 */
		private var _localeMap: Dictionary;
		
		/**
		 * Constructor.
		 */
		public function Localizer()
		{
			super();
			
			_localeMap = new Dictionary;
		}
		
		/**
		 * @copy org.robotlegs.utilities.localizer.core.ILocalizer.localize()
		 */
		public function localize( code: String ): void
		{
			dispatch( new LocalizerEvent( LocalizerEvent.LOCALIZE_DATA, getLocale( code )));
		}
		
		/**
		 * @copy org.robotlegs.utilities.localizer.core.ILocalizer.localizeCustomData()
		 */
		public function localizeCustomData( data: Object, prefix: String = '' ): void
		{
			dispatch( new LocalizerEvent( LocalizerEvent.LOCALIZE_DATA, null, data, prefix ));
		}
		
		 /**
		 * @copy org.robotlegs.utilities.localizer.core.ILocalizer.addLocale()
		 */
		public function addLocale( code: String, data: Object ): void
		{
			_localeMap[ code ] = new Locale( code, data );
		}

		/**
		 * @copy org.robotlegs.utilities.localizer.core.ILocalizer.hasLocale()
		 */
		public function hasLocale( code: String ): Boolean
		{
			return _localeMap[ code ] != null;
		}

		/**
		 * @copy org.robotlegs.utilities.localizer.core.ILocalizer.getLocale()
		 */
		public function getLocale( code: String ): ILocale
		{
			return _localeMap[ code ];
		}

		/**
		 * @copy org.robotlegs.utilities.localizer.core.ILocalizer.removeLocale()
		 */
		public function removeLocale( code: String ): ILocale
		{
			var locale: ILocale;
			
			if( hasLocale( code )) {
				locale = getLocale( code );
				
				_localeMap[ code ] = null;
			}
			
			return locale;
		}
	}
}