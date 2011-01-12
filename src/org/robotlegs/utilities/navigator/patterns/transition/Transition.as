package org.robotlegs.utilities.navigator.patterns.transition
{
	import org.robotlegs.utilities.navigator.patterns.page.IPage;
	import org.robotlegs.utilities.navigator.utils.NavigatorUtil;

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
			NavigatorUtil.setOnTransitionInComplete( page );
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
			NavigatorUtil.setOnTransitionOutComplete( page );
		}
	}
}