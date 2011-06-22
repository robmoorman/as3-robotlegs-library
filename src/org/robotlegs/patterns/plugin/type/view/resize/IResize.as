package org.robotlegs.patterns.plugin.type.view.resize
{
	/**
	 * The interface definition for a viewComponent which is automated by the <code>ResizePlugin</code>.
	 * 
	 * @author r.moorman
	 */
	public interface IResize
	{
		
		
		/**
		 * Resize the viewComponent according the dimensions of the <code>Stage</code>.
		 * 
		 * @param stageWidth The width of the <code>Stage</code>.
		 * @param stageHeight The height of the <code>Stage</code>.
		 */
		function resize( stageWidth: Number, stageHeight: Number ): void;
	}
}