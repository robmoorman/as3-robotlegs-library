package org.robotlegs.patterns.plugin.type.view
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import org.robotlegs.patterns.plugin.IPlugin;

	/**
	 * The interface definition for <code>ViewPlugin</code>.
	 * 
	 * @author r.moorman
	 */
	public interface IViewPlugin extends IPlugin
	{
		/**
		 * 
		 * 
		 * @param stage The <code>Stage</code> where the viewComponent is added on.
		 * @param target The viewComponent which is added on the <code>Stage</code>.
		 */
		function addedToStage( stage: Stage, target: DisplayObject ): void;
		
		/**
		 * 
		 * 
		 * @param stage The <code>Stage</code> where the viewComponent is removed from.
		 * @param target The viewComponent which is removed from the <code>Stage</code>.
		 */
		function removedFromStage( stage: Stage, target: DisplayObject ): void;
	}
}