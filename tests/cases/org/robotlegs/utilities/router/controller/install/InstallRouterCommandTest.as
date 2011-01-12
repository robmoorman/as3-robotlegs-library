package cases.org.robotlegs.utilities.router.controller.install
{
	import flash.display.Sprite;
	
	import flexunit.framework.Assert;
	
	import org.robotlegs.mvcs.ContextHelper;
	import org.robotlegs.utilities.Utilities;
	import org.robotlegs.utilities.navigator.events.NavigatorEvent;
	import org.robotlegs.utilities.router.controller.route.MapEventToRouteCommand;
	import org.robotlegs.utilities.router.core.IRouter;
	import org.robotlegs.utilities.router.events.RouterEvent;
	
	public class InstallRouterCommandTest
	{
		private var helper: ContextHelper;
		
		[Before]
		public function initialize(): void
		{
			helper = new ContextHelper( new Sprite );
			
			Utilities.mapDepedencies( helper.getCommandMap(), [ Utilities.ROUTER ]);
		}
		
		[Test]
		public function hasDepedenciesMapped(): void
		{
			Assert.assertTrue( 'Injector must have Router mapped to IRouter!', helper.getInjector().hasMapping( IRouter ));
			Assert.assertTrue( 'CommandMap must have MapEventToRouteCommand mapped to RouterEvent.MAP_EVENT_TO_ROUTE!', helper.getCommandMap().hasEventCommand( RouterEvent.MAP_EVENT_TO_ROUTE, MapEventToRouteCommand, RouterEvent ));
		}
	}
}