package org.robotlegs.utilities.layers.controller.layer
{
	import flash.display.DisplayObject;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.layers.error.LayersError;
	import org.robotlegs.utilities.layers.events.LayersEvent;
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class TransferLayerCommand extends Command
	{
		[Inject]
		/**
		 * 
		 */
		public var event: LayersEvent;
		
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			var layer: ILayer = event.layer;
			
			try {
				contextView.addChildAt( layer as DisplayObject, event.index );
			}
			catch( e: Error ) {
				throw new LayersError( 'Layer ' + layer.name + ' could not be transfered to index ' + event.index + '!' );
			}
		}
	}
}