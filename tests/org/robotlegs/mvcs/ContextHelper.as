package org.robotlegs.mvcs
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.core.IInjector;

	public class ContextHelper extends Context
	{
		public function ContextHelper( contextView: DisplayObjectContainer, autoStartup: Boolean = true )
		{
			super( contextView, autoStartup );
		}
		
		public function getInjector(): IInjector {
			return injector;
		}
		
		public function getCommandMap(): ICommandMap {
			return commandMap;
		}
	}
}