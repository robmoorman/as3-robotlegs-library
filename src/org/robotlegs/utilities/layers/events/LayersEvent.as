package org.robotlegs.utilities.layers.events
{
	import flash.events.Event;
	
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class LayersEvent extends Event
	{
		/**
		 * 
		 */
		public static const ADD_LAYER: String = 'org.robotlegs.utilities.layers.events.LayersEvent.ADD_LAYER';
		
		/**
		 * 
		 */
		public static const REMOVE_LAYER: String = 'org.robotlegs.utilities.layers.events.LayersEvent.REMOVE_LAYER';
		
		/**
		 * 
		 */
		public static const TRANSFER_LAYER: String = 'org.robotlegs.utilities.layers.events.LayersEvent.TRANSFER_LAYER';
		
		/**
		 * 
		 * 
		 * @default null
		 */
		public var layer: ILayer;
		
		/**
		 * 
		 * 
		 * @default null
		 */
		public var index: int;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param layer
		 * @param index
		 * @param bubbles
		 * @param cancelable
		 */
		public function LayersEvent( type: String, layer: ILayer, index: int = -1, bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			this.layer = layer;
			this.index = index;
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