package org.robotlegs.utilities.layers.patterns.layer
{
	import flash.display.DisplayObject;

	/**
	 * The interface definition for <code>Layers</code>.
	 * 
	 * @author r.moorman
	 */
	public interface ILayer
	{
		/**
		 * The name of the <code>Layer</code>.
		 */
		function get name(): String;
		
		/**
		 * Lock the user interface of the <code>Layer</code>.
		 */
		function lock(): void;
		
		/**
		 * Unlock the user interface of the <code>Layer</code>.
		 */
		function unlock(): void;
		
		/**
		 * @copy flash.display.DisplayObjectContainer.addChild
		 */
		function addChild( child: DisplayObject ): DisplayObject;
		
		/**
		 * @copy flash.display.DisplayObjectContainer.addChildAt
		 */
		function addChildAt( child: DisplayObject, index: int ): DisplayObject;
		
		/**
		 * @copy flash.display.DisplayObjectContainer.getChildAt
		 */
		function getChildAt( index: int ): DisplayObject;
		
		/**
		 * @copy flash.display.DisplayObjectContainer.getChildByName
		 */
		function getChildByName( name: String ): DisplayObject;
		
		/**
		 * @copy flash.display.DisplayObjectContainer.getChildIndex
		 */
		function getChildIndex( child: DisplayObject ): int;
		
		/**
		 * @copy flash.display.DisplayObjectContainer.removeChild
		 */
		function removeChild( child: DisplayObject ): DisplayObject;
		
		/**
		 * @copy flash.display.DisplayObjectContainer.removeChildAt
		 */
		function removeChildAt( index: int ): DisplayObject;
	}
}