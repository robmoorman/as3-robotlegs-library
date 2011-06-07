package org.robotlegs.patterns.plugin
{
	import flash.display.DisplayObject;
	import flash.display.Stage;

	public interface IPlugin
	{
		function addedToStage( stage: Stage, target: DisplayObject ): void;
		
		function removedFromStage( stage: Stage, target: DisplayObject ): void;
	}
}