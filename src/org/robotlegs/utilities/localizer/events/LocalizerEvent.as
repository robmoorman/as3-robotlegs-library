package org.robotlegs.utilities.localizer.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class LocalizerEvent extends Event
	{
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function LocalizerEvent( type: String,bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new LocalizerEvent( type, bubbles, cancelable );
		}
	}
}