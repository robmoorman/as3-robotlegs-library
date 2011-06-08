package org.robotlegs.patterns.plugin.type.view.dealloc
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import org.robotlegs.patterns.plugin.type.view.IViewPlugin;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class DeallocPlugin implements IViewPlugin
	{
		/**
		 * @constructor
		 */
		public function DeallocPlugin()
		{
			
		}
		
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.addedToStage()
		 */
		public function addedToStage( stage: Stage, target: DisplayObject ): void
		{
			
		}
		
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.removedFromStage()
		 */
		public function removedFromStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is IDealloc ) {
				( target as IDealloc ).dealloc( stage );
			}
		}
	}
}