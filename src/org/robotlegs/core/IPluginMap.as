package org.robotlegs.core
{
	import org.robotlegs.patterns.plugin.IPlugin;

	public interface IPluginMap
	{
		/**
		 * 
		 * 
		 * @param plugin
		 */
		function addPlugin( plugin: IPlugin ): void;
		
		/**
		 * 
		 * @param pluginClass
		 * @return 
		 */
		function removePlugin( pluginClass: Class ): void;
		
		/**
		 * 
		 * @param pluginClass
		 * @return 
		 */
		function hasPlugin( pluginClass: Class ): Boolean;
	}
}