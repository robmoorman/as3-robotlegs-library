package org.robotlegs.utilities.localizer.events
{
	import flash.events.Event;
	
	import org.robotlegs.utilities.localizer.patterns.locale.ILocale;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class LocalizerEvent extends Event
	{
		/**
		 * 
		 */
		public static const LOCALIZE_DATA: String = 'org.robotlegs.utilities.localizer.events.LocalizerEvent.LOCALIZE_DATA';
		
		/**
		 * 
		 * 
		 * @default null
		 */
		public var locale: ILocale;
		
		/**
		 * 
		 * 
		 * @default null
		 */
		public var data: Object;
		
		/**
		 * 
		 * 
		 * @default null
		 */
		public var prefix: String;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param locale
		 * @param prefix
		 * @param bubbles
		 * @param cancelable
		 */
		public function LocalizerEvent( type: String, locale: ILocale, data: Object = null, prefix: String = '', bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			this.locale = locale;
			this.data = data;
			this.prefix = prefix;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new LocalizerEvent( type, locale, data, prefix, bubbles, cancelable );
		}
	}
}