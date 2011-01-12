package org.robotlegs.utilities.navigator.utils
{
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.utilities.navigator.events.NavigatorEvent;
	import org.robotlegs.utilities.navigator.patterns.page.IPage;
	
	/**
	 * Utility to provide consistent <code>Transition</code> methods.
	 * 
	 * @author r.moorman
	 */
	public class NavigatorUtil
	{
		/**
		 * 
		 * 
		 * @param page
		 */
		public static function setOnTransitionInComplete( page: IPage ): void
		{
			( page as IEventDispatcher ).dispatchEvent( new NavigatorEvent( NavigatorEvent.TRANSITION_IN_COMPLETE, page ));
		}
		
		/**
		 * 
		 * 
		 * @param page
		 */
		public static function setOnTransitionOutComplete( page: IPage ): void
		{
			( page as IEventDispatcher ).dispatchEvent( new NavigatorEvent( NavigatorEvent.TRANSITION_OUT_COMPLETE, page ));
		}
	}
}