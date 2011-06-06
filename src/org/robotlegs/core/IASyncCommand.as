package org.robotlegs.core
{
	/**
	 * Abstract <code>IASyncCommand</code> interface.
	 * 
	 * @author r.moorman
	 * https://github.com/moorinteractive/as3-robotlegs-library/wiki/asyncmacrocommand
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