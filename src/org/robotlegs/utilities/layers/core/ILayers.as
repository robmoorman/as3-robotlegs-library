package org.robotlegs.utilities.layers.core
{
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;

	/**
	 * The interface definition for <code>Layers</code>.
	 * 
	 * @author r.moorman
	 * @see org.robotlegs.utilities.navigator.core.Navigator
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/layers
	 */
	public interface ILayers
	{
		/**
		 * Add a new <code>Layer</code>.
		 * 
		 * @param name The name of the <code>Layer</code>.
		 * @return A new instance of <code>Layer</code>.
		 */
		function addLayer( name: String ): ILayer;
		
		/**
		 * Check if a <code>Layer</code> exists under a name.
		 * 
		 * @param name The name of the <code>Layer</code>.
		 * @return <code>True</code> or <code>False</code>.
		 */
		function hasLayer( name: String ): Boolean;
		
		/**
		 * Get a <code>Layer</code> by it's id.
		 * 
		 * @param name The name of the <code>Layer</code>.
		 * @return An instance of <code>Layer</code>, <code>null</code> if not found.
		 */
		function getLayer( name: String ): ILayer;
		
		/**
		 * Remove a <code>Layer</code> by it's id.
		 * 
		 * @param name The name of the <code>Layer</code>.
		 * @return An instance of <code>Layer</code>, <code>null</code> if not found.
		 */
		function removeLayer( name: String ): ILayer;
		
		/**
		 * Transfer a <code>Layer</code> to an other childIndex.
		 * 
		 * @param name The name of the <code>Layer</code>.
		 * @param index The upcoming childIndex.
		 */
		function transferLayer( name: String, index: int ): ILayer;
		
		/**
		 * Lock the user interface of all layers.
		 */
		function lock(): void;
		
		/**
		 * Lock the user interface of all layers.
		 */
		function unlock(): void;
	}
}