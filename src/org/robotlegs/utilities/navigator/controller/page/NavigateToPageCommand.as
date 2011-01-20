package org.robotlegs.utilities.navigator.controller.page
{
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.utilities.navigator.core.INavigator;
	import org.robotlegs.utilities.navigator.error.NavigatorError;
	import org.robotlegs.utilities.navigator.events.NavigatorEvent;
	import org.robotlegs.utilities.navigator.patterns.page.IPage;
	import org.robotlegs.utilities.navigator.patterns.transition.ITransition;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class NavigateToPageCommand extends Command
	{
		[Inject]
		/**
		 * 
		 */
		public var event: NavigatorEvent;
		
		[Inject]
		/**
		 * 
		 */
		public var navigator: INavigator;
		
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			var page: IPage = event.page;
			
			if( navigator.currentPage && navigator.currentPage.name != page.name ) {
				navigator.choosenPage = page;
				
				transition( navigator.currentPage, false );
			}
			else if( !navigator.currentPage ) {
				navigator.currentPage = page;
				
				transition( page, true );
			}
		}
		
		/**
		 * 
		 * 
		 * @param page
		 * @param transition Determine if there should be transitioned in or out.
		 */
		private function transition( page: IPage, transitionIn: Boolean ): void
		{
			var type: String  = transitionIn ? NavigatorEvent.TRANSITION_IN_COMPLETE : NavigatorEvent.TRANSITION_OUT_COMPLETE;
			var closure: Function = transitionIn ? onTransitionInComplete : onTransitionOutComplete;
			var property: String = transitionIn ? 'transitionIn' : 'transitionOut';
			
			navigator.transitioning = true;
			
			IEventDispatcher( page ).addEventListener( type, closure );
			
			IEventDispatcher( page ).dispatchEvent( new NavigatorEvent( transitionIn ? NavigatorEvent.TRANSITION_IN : NavigatorEvent.TRANSITION_OUT, page ));
			
			if( page is ITransition ) {
				ITransition( page )[ property ]( page );
			}
			else if( navigator.hasTransitionByPageName( page.name )) {
				navigator.getTransitionByPageName( page.name )[ property ]( page );
			}
			else if( navigator.defaultTransition ) {
				navigator.defaultTransition[ property ]( page );
			}
			else {
				navigator.transitioning = false;
				
				IEventDispatcher( page ).removeEventListener( type, closure );
				
				throw new NavigatorError( 'Page is not of type ITransition, Navigator does not have a Transition for ' + page.name + ' and Navigator does not have a default Transition!' );
			}
		}
		
		/**
		 * 
		 * 
		 * @param evt
		 */
		private function onTransitionInComplete( evt: NavigatorEvent ): void
		{
			IEventDispatcher( evt.page ).removeEventListener( NavigatorEvent.TRANSITION_IN_COMPLETE, onTransitionInComplete );
			
			navigator.transitioning = false;
		}
		
		/**
		 * 
		 * 
		 * @param evt
		 */
		private function onTransitionOutComplete( evt: NavigatorEvent ): void
		{
			IEventDispatcher( evt.page ).removeEventListener( NavigatorEvent.TRANSITION_OUT_COMPLETE, onTransitionOutComplete );
			
			if( navigator.choosenPage ) {
				navigator.currentPage = navigator.choosenPage;
				
				navigator.choosenPage = null;
				
				transition( navigator.currentPage, true );
			}
		}
	}
}