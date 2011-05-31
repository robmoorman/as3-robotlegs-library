package org.robotlegs.utilities.router.controller.install
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.router.controller.route.MapEventToRouteCommand;
	import org.robotlegs.utilities.router.controller.route.RemoveEventFromRouteCommand;
	import org.robotlegs.utilities.router.core.IRouter;
	import org.robotlegs.utilities.router.core.Router;
	import org.robotlegs.utilities.router.events.RouterEvent;

	/**
	 * Map dependencies of <code>Router</code>.
	 * 
	 * <p>The following depedencies are available after executing this <code>Command</code>:</p>
	 * <ul>
	 * 	<li><code>IRouter</code></li>
	 * </ul>
	 * 
	 * @author r.moorman
	 */
	public class InstallRouterCommand extends Command
	{
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			injector.mapSingletonOf( IRouter, Router );
			
			commandMap.mapEvent( RouterEvent.MAP_EVENT_TO_ROUTE, MapEventToRouteCommand, RouterEvent );
			commandMap.mapEvent( RouterEvent.REMOVE_EVENT_FROM_ROUTE, RemoveEventFromRouteCommand, RouterEvent );
		}
	}
}