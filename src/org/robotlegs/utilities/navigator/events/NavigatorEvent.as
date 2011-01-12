package org.robotlegs.utilities.navigator.events
{
	import flash.events.Event;
	
	import org.robotlegs.utilities.navigator.patterns.page.IPage;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class NavigatorEvent extends Event
	{
		/**
		 * 
		 */
		public static const TRANSITION_IN_COMPLETE: String = 'org.robotlegs.utilities.navigator.events.NavigatorEvent.TRANSITION_IN_COMPLETE';
		
		/**
		 * 
		 */
		public static const TRANSITION_OUT_COMPLETE: String = 'org.robotlegs.utilities.navigator.events.NavigatorEvent.TRANSITION_OUT_COMPLETE';
		
		/**
		 * 
		 * 
		 * @default null
		 */
		public var page: IPage;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function NavigatorEvent( type: String, page: IPage, bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			this.page = page;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new NavigatorEvent( type, page, bubbles, cancelable );
		}
	}
}