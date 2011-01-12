package org.robotlegs.utilities.assetloader.controller.install
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.assetloader.core.AssetLoader;
	import org.robotlegs.utilities.assetloader.core.IAssetLoader;
	
	/**
	 * Map dependencies of <code>AssetLoader</code>.
	 * 
	 * <p>The following depedencies are available after executing this <code>Command</code>:</p>
	 * <ul>
	 * 	<li><code>IAssetLoader</code></li>
	 * </ul>
	 * 
	 * @author r.moorman
	 */
	public class InstallAssetLoaderCommand extends Command
	{
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			injector.mapSingletonOf( IAssetLoader, AssetLoader );
		}
	}
}