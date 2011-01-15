package org.robotlegs.utilities
{
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.utilities.assetloader.controller.install.InstallAssetLoaderCommand;
	import org.robotlegs.utilities.navigator.controller.install.InstallNavigatorCommand;
	import org.robotlegs.utilities.router.controller.install.InstallRouterCommand;
	
	/**
	 * Utility to map dependencies of certain utilities.
	 * 
	 * <p>Probably the place to do your mappings is in the <code>mapInjections</code> method
	 * of your <code>Context</code>. You can simply call the method <code>mapDepedencies</code>
	 * of <code>Utilities</code> to do all your mappings for the following utilities.</p>
	 * 
	 * <ul>
	 * 	<li><code>AssetLoader</code></li>
	 * 	<li><code>Router</code></li>
	 * </ul>
	 * 
	 * @author r.moorman
	 */
	public class Utilities
	{
		/**
		 * Map dependencies of all utilities.
		 */
		public static const ALL: String = 'all';
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.controller.install.InstallAssetLoaderCommand
		 */
		public static const ASSET_LOADER: Class = InstallAssetLoaderCommand;
		
		/**
		 * @copy org.robotlegs.utilities.navigator.controller.install.InstallNavigatorCommand
		 */
		public static const NAVIGATOR: Class = InstallNavigatorCommand;
		
		/**
		 * @copy org.robotlegs.utilities.router.controller.install.InstallRouterCommand
		 */
		public static const ROUTER: Class = InstallRouterCommand;
		
		/**
		 * Map dependencies of certain utilities.
		 * 
		 * @param commandMap The <code>ICommandMap</code> of Robotlegs.
		 * @param utilities The utilities to map the dependencies of, must be one or multiple constants of this <code>Class</code>.
		 */
		public static function mapDepedencies( commandMap: ICommandMap, utilities: Array ): void
		{
			var utilityClass: Class;
			
			if( utilities.indexOf( ALL ) != -1 )
				utilities = [ ASSET_LOADER, NAVIGATOR, ROUTER ];
			
			for each( utilityClass in utilities )
				commandMap.execute( utilityClass );
		}
	}
}