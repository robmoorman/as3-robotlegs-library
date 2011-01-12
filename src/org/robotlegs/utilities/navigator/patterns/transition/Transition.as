package org.robotlegs.utilities.navigator.patterns.transition
{
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.utilities.navigator.events.NavigatorEvent;
	import org.robotlegs.utilities.navigator.patterns.page.IPage;

	/**
	 * Abstract <code>Transition</code> implementation.
	 * 
	 * @author r.moorman
	 */
	public class Transition implements ITransition
	{
		/**
		 * Constructor.
		 */
		public function Transition()
		{
			
		}
		
		/**
		 * @copy org.robotlegs.utilities.navigator.patterns.transition.ITransition.transitionIn()
		 */
		public function transitionIn( page: IPage ): void
		{
			transitionInComplete( page );
		}
		
		/**
		 * @copy org.robotlegs.utilities.navigator.patterns.transition.ITransition.transitionInComplete()
		 */
		public function transitionInComplete( page: IPage ): void
		{
			( page as IEventDispatcher ).dispatchEvent( new NavigatorEvent( NavigatorEvent.TRANSITION_IN_COMPLETE, page ));
		}
		
		/**
		 * @copy org.robotlegs.utilities.navigator.patterns.transition.ITransition.transitionOut()
		 */
		public function transitionOut( page: IPage ): void
		{
			transitionOutComplete( page );
		}
		
		/**
		 * @copy org.robotlegs.utilities.navigator.patterns.transition.ITransition.transitionOutComplete()
		 */
		public function transitionOutComplete( page: IPage ): void
		{
			( page as IEventDispatcher ).dispatchEvent( new NavigatorEvent( NavigatorEvent.TRANSITION_OUT_COMPLETE, page ));
		}
	}
}