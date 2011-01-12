package org.robotlegs.utilities.navigator.controller.install
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.navigator.controller.page.NavigateToPageCommand;
	import org.robotlegs.utilities.navigator.core.INavigator;
	import org.robotlegs.utilities.navigator.core.Navigator;
	import org.robotlegs.utilities.navigator.events.NavigatorEvent;
	
	
	/**
	 * Map dependencies of <code>Navigator</code>.
	 * 
	 * <p>The following depedencies are available after executing this <code>Command</code>:</p>
	 * 
	 * <ul>
	 * 	<li><code>INavigator</code></li>
	 * </ul>
	 * 
	 * @author r.moorman
	 */
	public class InstallNavigatorCommand extends Command
	{
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			injector.mapSingletonOf( INavigator, Navigator );
			
			commandMap.mapEvent( NavigatorEvent.NAVIGATE, NavigateToPageCommand, NavigatorEvent );
		}
	}
}