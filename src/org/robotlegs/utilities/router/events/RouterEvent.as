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