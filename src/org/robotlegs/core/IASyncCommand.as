package org.robotlegs.core
{
	/**
	 * Abstract <code>IASyncCommand</code> interface.
	 * 
	 * @author r.moorman
	 */
	public interface IASyncCommand
	{
		/**
		 * 
		 * 
		 * @param value
		 */		
		function setOnComplete( value: Function ): void;
	}
}