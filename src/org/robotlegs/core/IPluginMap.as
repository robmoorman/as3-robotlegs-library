package org.robotlegs.core
{
	import org.robotlegs.patterns.plugin.IPlugin;

	/**
	 * The interface definition for <code>PluginMap</code>.
	 * 
	 * @author r.moorman
	 */
	public interface IPluginMap
	{
		/**
		 * Add a plugin for automatic operations.
		 * 
		 * <p>Available types of plugins:</p>
		 * 
		 * <ul>
		 * 	<li><code>IPlugin</code></li>
		 * 	<li><code>IViewPlugin</code></li>
		 * </ul>
		 * 
		 * <p><code>PluginMap</code> comes with some pre-programmed plugins:</p>
		 * 
		 * <ul>
		 * 	<li><code>DeallocPlugin</code></li>
		 * 	<li><code>ResizePlugin</code></li>
		 * </ul>
		 * 
		 * @param plugin An instance of a plugin.
		 * 
		 * @see org.robotlegs.patterns.plugin.Plugin
		 * @see org.robotlegs.patterns.plugin.type.view.ViewPlugin
		 * @see org.robotlegs.patterns.plugin.type.view.dealloc.DeallocPlugin
		 * @see org.robotlegs.patterns.plugin.type.view.resize.ResizePlugin
		 */
		function addPlugin( plugin: IPlugin ): void;
		
		/**
		 * Remove a plugin.
		 * 
		 * @param pluginClass The <code>Class</code> type of the plugin.
		 */
		function removePlugin( pluginClass: Class ): void;
		
		/**
		 * Determine is a plugin is available.
		 * 
		 * @param pluginClass The <code>Class</code> type of the plugin.
		 * @return 
		 */
		function hasPlugin( pluginClass: Class ): Boolean;
	}
}