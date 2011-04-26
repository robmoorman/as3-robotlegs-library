package org.robotlegs.utilities.styles.controller.install
{
	import org.robotlegs.core.IViewMap;
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.Utilities;
	import org.robotlegs.utilities.assetloader.core.IAssetLoader;
	import org.robotlegs.utilities.styles.core.IStyles;
	import org.robotlegs.utilities.styles.core.Styles;
	import org.robotlegs.utilities.styles.view.StylesTextfield;
	
	/**
	 * Map dependencies of <code>Styles</code>.
	 * 
	 * <p>The following depedencies are available after executing this <code>Command</code>:</p>
	 * 
	 * <ul>
	 * 	<li><code>IStyles</code></li>
	 * </ul>
	 * 
	 * @author r.moorman
	 */
	public class InstallStylesCommand extends Command
	{
		[Inject]
		/**
		 * 
		 */
		public var viewMap: IViewMap;
		
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			if( !injector.hasMapping( IAssetLoader )) {
				Utilities.mapDependencies( commandMap, [ Utilities.ASSET_LOADER ]);
			}
			
			injector.mapSingletonOf( IStyles, Styles );
			
			viewMap.mapType( StylesTextfield );
		}
	}
}