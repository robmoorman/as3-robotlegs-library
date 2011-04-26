package org.robotlegs.utilities.layers.controller.install
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.layers.controller.layer.AddLayerCommand;
	import org.robotlegs.utilities.layers.controller.layer.RemoveLayerCommand;
	import org.robotlegs.utilities.layers.controller.layer.TransferLayerCommand;
	import org.robotlegs.utilities.layers.core.ILayers;
	import org.robotlegs.utilities.layers.core.Layers;
	import org.robotlegs.utilities.layers.events.LayersEvent;
	
	/**
	 * Map dependencies of <code>Layers</code>.
	 * 
	 * <p>The following depedencies are available after executing this <code>Command</code>:</p>
	 * 
	 * <ul>
	 * 	<li><code>ILayers</code></li>
	 * </ul>
	 * 
	 * @author r.moorman
	 */
	public class InstallLayersCommand extends Command
	{
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			injector.mapSingletonOf( ILayers, Layers );
			
			commandMap.mapEvent( LayersEvent.ADD_LAYER, AddLayerCommand, LayersEvent );
			commandMap.mapEvent( LayersEvent.REMOVE_LAYER, RemoveLayerCommand, LayersEvent );
			commandMap.mapEvent( LayersEvent.TRANSFER_LAYER, TransferLayerCommand, LayersEvent );
		}
	}
}