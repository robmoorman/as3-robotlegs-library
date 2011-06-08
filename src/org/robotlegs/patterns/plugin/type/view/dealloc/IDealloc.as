package org.robotlegs.patterns.plugin.type.view.dealloc
{
	import flash.display.Stage;

	/**
	 * The interface definition for a viewComponent which is automated by the <code>DeallocPlugin</code>.
	 * 
	 * @author r.moorman
	 */
	public interface IDealloc
	{
		/**
		 * Deallocate all references of the viewComponent.
		 * 
		 * @param fromStage The <code>Stage</code> where the viewComponent is removed from.
		 */
		function dealloc( fromStage: Stage ): void;
	}
}