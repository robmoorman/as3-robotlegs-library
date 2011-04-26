package org.robotlegs.utilities.styles.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class StylesEvent extends Event
	{
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function StylesEvent( type: String, bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new StylesEvent( type, bubbles, cancelable );
		}
	}
}