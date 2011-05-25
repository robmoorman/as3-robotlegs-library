package org.robotlegs.utilities.localizer.events
{
	import flash.events.Event;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.localizer.patterns.locale.ILocale;
	
	/**
	 * Custom <code>Event</code> for <code>Localizer</code>.
	 * 
	 * @author r.moorman
	 */
	public class LocalizerEvent extends Event
	{
		/**
		 * Dispatched when <code>XMl</code> or <code>Object</code> data should be localized.
		 */
		public static const LOCALIZE_DATA: String = 'org.robotlegs.utilities.localizer.events.LocalizerEvent.LOCALIZE_DATA';
		
		/**
		 * 
		 */
		public var locale: ILocale;
		
		/**
		 * 
		 */
		public var data: Object;
		
		/**
		 * 
		 */
		public var prefix: String;
		
		/**
		 * 
		 */
		public var childInjector: IInjector;
		
		/**
		 * Constructor.
		 * 
		 * @param type The type of <code>Event</code>.
		 * @param locale
		 * @param prefix
		 * @param childInjector
		 * @param bubbles
		 * @param cancelable
		 */
		public function LocalizerEvent( type: String, locale: ILocale, data: Object = null, prefix: String = '', childInjector: IInjector = null, bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			this.locale = locale;
			this.data = data;
			this.prefix = prefix;
			this.childInjector = childInjector;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new LocalizerEvent( type, locale, data, prefix, childInjector, bubbles, cancelable );
		}
	}
}