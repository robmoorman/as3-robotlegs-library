package cases.org.robotlegs.utilities.navigator.core.install
{
	import flash.display.Sprite;
	
	import flexunit.framework.Assert;
	
	import org.robotlegs.mvcs.ContextHelper;
	import org.robotlegs.utilities.Utilities;
	import org.robotlegs.utilities.navigator.controller.page.NavigateToPageCommand;
	import org.robotlegs.utilities.navigator.core.INavigator;
	import org.robotlegs.utilities.navigator.events.NavigatorEvent;

	public class InstallNavigatorCommandTest
	{
		private var helper: ContextHelper;
		
		[Before]
		public function initialize(): void
		{
			helper = new ContextHelper( new Sprite );
			
			Utilities.mapDependencies( helper.getCommandMap(), [ Utilities.NAVIGATOR ]);
		}
		
		[Test]
		public function hasDepedenciesMapped(): void
		{
			Assert.assertTrue( 'Injector must have Navigator mapped to INavigator!', helper.getInjector().hasMapping( INavigator ));
			Assert.assertTrue( 'CommandMap must have NavigateToPageCommand mapped to NavigatorEvent.NAVIGATE!', helper.getCommandMap().hasEventCommand( NavigatorEvent.NAVIGATE, NavigateToPageCommand, NavigatorEvent ));
		}
	}
}