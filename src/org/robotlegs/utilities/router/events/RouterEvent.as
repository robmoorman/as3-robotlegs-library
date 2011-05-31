package org.robotlegs.utilities.router.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class RouterEvent extends Event
	{
		/**
		 * Dispatched when the changed address doesn't match with any <code>Route</code>.
		 */
		public static const NO_ROUTE_FOUND: String = 'org.robotlegs.utilities.router.events.RouterEvent.NO_ROUTE_FOUND';
		
		/**
		 * Dispatched when a new <code>Route</code> is added and it should be mapped to a <code>Command</code>.
		 */
		public static const MAP_EVENT_TO_ROUTE: String = 'org.robotlegs.utilities.router.events.RouterEvent.MAP_EVENT_TO_ROUTE';
		
		
		/**
		 * Dispatched when a <code>Route</code> should be unmapped from a <code>Command</code>.
		 */
		public static const REMOVE_EVENT_FROM_ROUTE: String = 'org.robotlegs.utilities.router.events.RouterEvent.REMOVE_EVENT_FROM_ROUTE';
		
		/**
		 * 
		 * 
		 * @default null
		 */
		public var payload: Object;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param payload
		 * @param bubbles
		 * @param cancelable
		 */
		public function RouterEvent( type: String, payload: Object = null, bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			this.payload = payload;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new RouterEvent( type, payload, bubbles, cancelable );
		}
	}
}