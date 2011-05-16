package org.robotlegs.utilities.layers.controller.layer
{
	import flash.display.DisplayObject;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.layers.events.LayersEvent;
	import org.robotlegs.utilities.layers.patterns.layer.ILayer;

	/**
	 * Add a <code>Layer</code> to the <code>contextView</code>.
	 * 
	 * @author r.moorman
	 */
	public class AddLayerCommand extends Command
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
			
			contextView.addChild( layer as DisplayObject );
		}
	}
}