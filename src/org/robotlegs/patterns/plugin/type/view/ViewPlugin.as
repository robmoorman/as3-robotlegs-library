package org.robotlegs.patterns.plugin.type.view
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import org.robotlegs.patterns.plugin.IPlugin;
	
	/**
	 * Abstract implementation of <code>IViewPlugin</code>.
	 * 
	 * @author r.moorman
	 */
	public class ViewPlugin implements IPlugin
	{
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.addedToStage()
		 */
		public function addedToStage( stage: Stage, target: DisplayObject ): void
		{
			
		}
		
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.addedToStage()
		 */
		public function removedFromStage( stage: Stage, target: DisplayObject ): void
		{
			
		}
	}
}