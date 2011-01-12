package org.robotlegs.utilities.navigator.patterns.transition
{
	import org.robotlegs.utilities.navigator.patterns.page.IPage;

	/**
	 * Abstract <code>ITransition</code> interface.
	 * 
	 * @author r.moorman
	 */
	public interface ITransition
	{
		/**
		 * 
		 * @param page
		 */
		function transitionIn( page: IPage ): void;
		
		/**
		 * 
		 * @param page
		 */
		function transitionInComplete( page: IPage ): void;
		
		/**
		 * 
		 * @param page
		 */
		function transitionOut( page: IPage ): void;
		
		/**
		 * 
		 * @param page
		 */
		function transitionOutComplete( page: IPage ): void;
	}
}