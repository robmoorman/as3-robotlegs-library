package org.robotlegs.patterns.plugin.type.view
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import org.robotlegs.patterns.plugin.IPlugin;

	public interface IViewPlugin extends IPlugin
	{
		function addedToStage( stage: Stage, target: DisplayObject ): void;
		
		function removedFromStage( stage: Stage, target: DisplayObject ): void;
	}
}