package org.robotlegs.patterns.plugin.type.view.autoload
{
	/**
	 * @author koert
	 */
	public interface IAutoLoad
	{
		
		function get url():String;
		
		function get isLoaded():Boolean;
		function set isLoaded(value:Boolean):void;
		
		function callBack(payLoad:Object):void;
	}
}
