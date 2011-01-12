package cases.org.robotlegs.utilities.assetloader.controller.install
{
	import flash.display.Sprite;
	
	import flexunit.framework.Assert;
	
	import org.robotlegs.mvcs.ContextHelper;
	import org.robotlegs.utilities.Utilities;
	import org.robotlegs.utilities.assetloader.core.IAssetLoader;
	
	public class InstallAssetLoaderCommandTest
	{
		private var helper: ContextHelper;
		
		[Before]
		public function initialize(): void
		{
			helper = new ContextHelper( new Sprite );
			
			Utilities.mapDepedencies( helper.getCommandMap(), [ Utilities.ASSET_LOADER ]);
		}
		
		[Test]
		public function hasDepedenciesMapped(): void
		{
			Assert.assertTrue( 'Injector must have AssetLoader mapped to IAssetLoader!', helper.getInjector().hasMapping( IAssetLoader ));
		}
	}
}