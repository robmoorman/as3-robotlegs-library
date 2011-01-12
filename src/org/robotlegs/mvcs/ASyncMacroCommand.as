package org.robotlegs.mvcs
{
	import org.robotlegs.core.IASyncCommand;

	/**
	 * Abstract <code>ASyncMacroCommand</code> implementation.
	 * 
	 * @author r.moorman
	 */
	public class ASyncMacroCommand extends Command implements IASyncCommand
	{
		/**
		 * @private
		 */
		private var onComplete: Function;
		
		/**
		 * @private
		 */
		private var commands: Vector.<Command>;
		
		/**
		 * Constructor. 
		 */
		public function ASyncMacroCommand()
		{
			commands = new Vector.<Command>;
		}
		
		/**
		 * 
		 */
		final override public function execute(): void
		{
			executeNextCommand();
		}
		
		/**
		 * @copy org.robotlegs.core.IASyncCommand.setOnComplete()
		 */
		final public function setOnComplete( value: Function ): void
		{
			onComplete = value;
		}
		
		[PostConstruct]
		/**
		 * 
		 */
		final public function onPostConstruct(): void
		{
			initializeASyncMacroCommand();
		}
		
		/**
		 * 
		 */
		final protected function executeNextCommand(): void
		{
			if( commands.length ) {
				var command: Command = commands.shift();
				var commandIsASync: Boolean = command is IASyncCommand;
				
				if( commandIsASync )
					IASyncCommand( command ).setOnComplete( executeNextCommand );
				
				command.execute();
				
				if( !commandIsASync )
					executeNextCommand();
			}
			else {
				if( onComplete != null )
					onComplete.apply( this );
				
				onComplete = null;
			}
		}
		
		/**
		 * 
		 * 
		 * @param commandClass
		 */
		final protected function addSubCommand( commandClass: Class ): void
		{
			commands.push( injector.instantiate( commandClass ));
		}
		
		/**
		 * 
		 */
		protected function initializeASyncMacroCommand(): void
		{
			
		}
	}
}