package org.robotlegs.utilities.layers.controller.layer
{
	import flash.display.DisplayObject;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.layers.events.LayersEvent;
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;
	
	/**
	 * Remove a <code>Layer</code> from the <code>contextView</code>.
	 * 
	 * @author r.moorman
	 */
	public class RemoveLayerCommand extends Command
	{
		[Inject]
		/**
		 * The <code>LayersEvent</code> that executed this <code>Command</code>.
		 */
		public var event: LayersEvent;
		
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			var layer: ILayer = event.layer;
			
			contextView.removeChild( layer as DisplayObject );
		}
	}
}