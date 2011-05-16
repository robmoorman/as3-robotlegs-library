package org.robotlegs.utilities.layers.events
{
	import flash.events.Event;
	
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;
	
	/**
	 * Custom <code>Event</code> for <code>Layers</code>.
	 * 
	 * @author r.moorman
	 */
	public class LayersEvent extends Event
	{
		/**
		 * Dispatched when a <code>Layer</code> sould be added.
		 */
		public static const ADD_LAYER: String = 'org.robotlegs.utilities.layers.events.LayersEvent.ADD_LAYER';
		
		/**
		 * Dispatched when a <code>Layer</code> sould be removed.
		 */
		public static const REMOVE_LAYER: String = 'org.robotlegs.utilities.layers.events.LayersEvent.REMOVE_LAYER';
		
		/**
		 * Dispatched when a <code>Layer</code> sould be transfered.
		 */
		public static const TRANSFER_LAYER: String = 'org.robotlegs.utilities.layers.events.LayersEvent.TRANSFER_LAYER';
		
		/**
		 * The <code>Layer</code> to be handled.
		 */
		public function get layer(): ILayer {
			return _layer;
		}
		
		/**
		 * The childIndex to transfer the <code>Layer</code> to.
		 */
		public function get index(): int {
			return _index;
		}
		
		/**
		 * @private
		 */
		private var _layer: ILayer;
		
		/**
		 * @private
		 */
		private var _index: int;
		
		/**
		 * Constructor.
		 * 
		 * @param type The type of <code>Event</code>.
		 * @param layer The <code>Layer</code> to be handled.
		 * @param index The childIndex to transfer the <code>Layer</code> to.
		 * @param bubbles
		 * @param cancelable
		 */
		public function LayersEvent( type: String, layer: ILayer, index: int = -1, bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			_layer = layer;
			_index = index;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new LayersEvent( type, layer, index, bubbles, cancelable );
		}
	}
}