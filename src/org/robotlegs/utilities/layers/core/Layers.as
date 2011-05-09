package org.robotlegs.utilities.layers.core
{
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.utilities.layers.events.LayersEvent;
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;
	import org.robotlegs.utilities.layers.patterns.layer.Layer;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class Layers extends Actor implements ILayers
	{
		/**
		 * @private
		 */
		private var _layerMap: Dictionary;
		
		/**
		 * Constructor.
		 */
		public function Layers()
		{
			super();
			
			_layerMap = new Dictionary;
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.core.ILayers.addLayer()
		 */
		public function addLayer( name: String ): ILayer
		{
			var layer: ILayer = new Layer( name );
			
			_layerMap[ name ] = layer;
			
			dispatch( new LayersEvent( LayersEvent.ADD_LAYER, layer ));
			
			return layer;
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.core.ILayers.hasLayer()
		 */
		public function hasLayer( name: String ): Boolean
		{
			return _layerMap[ name ] != null;
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.core.ILayers.getLayer()
		 */
		public function getLayer( name: String ): ILayer
		{
			return _layerMap[ name ];
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.core.ILayers.removeLayer()
		 */
		public function removeLayer( name: String ): ILayer
		{
			var layer: ILayer;
			
			if( hasLayer( name )) {
				layer = getLayer( name );
				
				_layerMap[ name ] = null;
				
				dispatch( new LayersEvent( LayersEvent.REMOVE_LAYER, layer ));
			}
			
			return layer;
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.core.ILayers.transferLayer()
		 */
		public function transferLayer( name: String, index: int ): ILayer
		{
			var layer: ILayer = getLayer( name );
			
			dispatch( new LayersEvent( LayersEvent.TRANSFER_LAYER, layer, index ));
			
			return layer;
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.core.ILayers.lock()
		 */
		public function lock(): void
		{
			var layer: ILayer;
			
			for each( layer in _layerMap ) {
				layer.lock();
			}
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.core.ILayers.unlock()
		 */
		public function unlock(): void
		{
			var layer: ILayer;
			
			for each( layer in _layerMap ) {
				layer.unlock();
			}
		}
	}
}