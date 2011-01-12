package org.robotlegs.utilities.navigator.core
{
	import org.robotlegs.utilities.navigator.patterns.page.IPage;
	import org.robotlegs.utilities.navigator.patterns.transition.ITransition;

	/**
	 * Abstract <code>INavigator</code> interface.
	 * 
	 * @author r.moorman
	 */
	public interface INavigator
	{
		/**
		 * 
		 */
		function get transitioning(): Boolean;
		
		/**
		 * @private
		 */
		function set transitioning( value: Boolean ): void;
		
		/**
		 * 
		 */
		function get currentPage(): IPage;
		
		/**
		 * @private
		 */
		function set currentPage( value: IPage ): void;
		
		/**
		 * 
		 */
		function get choosenPage(): IPage;
		
		/**
		 * @private
		 */
		function set choosenPage( value: IPage ): void;
		
		/**
		 * 
		 */
		function get defaultTransition(): ITransition;
		
		/**
		 * @private
		 */
		function set defaultTransition( value: ITransition ): void;
		
		/**
		 * 
		 * 
		 * @param page
		 * @param transitionId
		 */
		function addPage( page: IPage, transitionId: String = null ): void;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return
		 */
		function hasPage( name: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return
		 */
		function getPage( name: String ): IPage;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return
		 */
		function removePage( name: String ): IPage;
		
		/**
		 * 
		 * 
		 * @param id
		 * @param transition
		 * @param isDefaultTransition
		 */
		function addTransition( id: String, transition: ITransition, isDefaultTransition: Boolean = false ): void;
		
		/**
		 * 
		 * 
		 * @param id
		 * @return
		 */
		function hasTransition( id: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param id
		 * @return
		 */
		function getTransition( id: String ): ITransition;
		
		/**
		 * 
		 * 
		 * @param id
		 * @return
		 */
		function removeTransition( id: String ): ITransition;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return
		 */
		function hasTransitionByPageName( name: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return
		 */
		function getTransitionByPageName( name: String ): ITransition;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return
		 */
		function removeTransitionByPageName( name: String ): ITransition;
		
		/**
		 * 
		 * @param name
		 * @return 
		 */
		function navigate( name: String ): Boolean;
	}
}