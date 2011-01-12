package org.robotlegs.mvcs
{
	import org.robotlegs.core.IASyncCommand;

	/**
	 * Abstract <code>ASyncCommand</code> implementation.
	 * 
	 * @author r.moorman
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
			onComplete.apply( this );
		}
	}
}