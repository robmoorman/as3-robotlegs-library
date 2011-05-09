package org.robotlegs.utilities.layers.core
{
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public interface ILayers
	{
		/**
		 * 
		 * 
		 * @param name
		 * @return 
		 */
		function addLayer( name: String ): ILayer;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return 
		 */
		function hasLayer( name: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param name
		 * @return 
		 */
		function getLayer( name: String ): ILayer;
		
		/**
		 * 
		 * @param name
		 * @return 
		 */
		function removeLayer( name: String ): ILayer;
		
		/**
		 * 
		 * 
		 * @param name
		 * @param index
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