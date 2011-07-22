package org.robotlegs.mvcs
{
	import org.robotlegs.core.IASyncCommand;

	/**
	 * Abstract <code>ASyncCommand</code> implementation.
	 * 
	 * @author r.moorman
	 * https://github.com/moorinteractive/as3-robotlegs-library/wiki/asynccommand
	 */
	public class ASyncCommand extends Command implements IASyncCommand
	{
		/**
		 * @private
		 */
		private var onComplete: Function;
		
		/**
		 * @copy org.robotlegs.core.IASyncCommand.setOnComplete()
		 */
		final public function setOnComplete( value: Function ): void
		{
			onComplete = value;
		}
		
		/**
		 * 
		 */
		final protected function commandComplete(): void
		{
			onComplete && onComplete.apply( this );
		}
	}
}