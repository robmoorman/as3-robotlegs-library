package org.robotlegs.patterns.plugin.type.view.dealloc
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import org.robotlegs.patterns.plugin.type.view.IViewPlugin;
	
	public class DeallocPlugin implements IViewPlugin
	{
		public function DeallocPlugin()
		{
			
		}
		
		public function addedToStage( stage: Stage, target: DisplayObject ): void
		{
			
		}
		
		public function removedFromStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is IDealloc ) {
				( target as IDealloc ).dealloc( stage );
			}
		}
	}
}