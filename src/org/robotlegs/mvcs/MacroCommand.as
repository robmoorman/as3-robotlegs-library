package org.robotlegs.mvcs
{
	/**
	 * Abstract <code>MacroCommand</code> implementation.
	 * 
	 * @author r.moorman
	 */
	public class MacroCommand extends Command
	{
		/**
		 * @private
		 */
		private var commands: Vector.<Command>;
		
		/**
		 * Constructor. 
		 */
		public function MacroCommand()
		{
			commands = new Vector.<Command>;
		}
		
		/**
		 * 
		 */
		final override public function execute(): void
		{
			while( commands.length ) {
				var command: Command = commands.shift();
				command.execute();
			}
		}
		
		[PostConstruct]
		/**
		 * 
		 */
		final public function onPostConstruct(): void
		{
			initializeMacroCommand();
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
		protected function initializeMacroCommand(): void
		{
			
		}
	}
}