package org.robotlegs.utilities.navigator.controller.install
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.layers.core.ILayers;
	import org.robotlegs.utilities.navigator.controller.page.NavigateToPageCommand;
	import org.robotlegs.utilities.navigator.core.INavigator;
	import org.robotlegs.utilities.navigator.core.Navigator;
	import org.robotlegs.utilities.navigator.events.NavigatorEvent;
	import org.robotlegs.utilities.Utilities;
	
	
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
			if( !injector.hasMapping( ILayers )) {
				Utilities.mapDependencies( commandMap, [ Utilities.LAYERS ]);
			}
			
			injector.mapSingletonOf( INavigator, Navigator );
			
			commandMap.mapEvent( NavigatorEvent.NAVIGATE, NavigateToPageCommand, NavigatorEvent );
		}
	}
}