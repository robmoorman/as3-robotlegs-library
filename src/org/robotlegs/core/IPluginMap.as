package org.robotlegs.core
{
	import org.robotlegs.patterns.plugin.IPlugin;

	public interface IPluginMap
	{
		/**
		 * 
		 * 
		 * @param id
		 * @param pluginClass
		 */
		function addPlugin( id: String, pluginClass: Class ): void;
		
		/**
		 * 
		 * @param id
		 * @return 
		 */
		function removePlugin( id: String ): IPlugin;
		
		/**
		 * 
		 * @param id
		 * @return 
		 */
		function hasPlugin( id: String ): Boolean;
	}
}