package org.robotlegs.mvcs
{
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.core.IReflector;
	import org.robotlegs.utils.ClassUtil;
	
	/**
	 * Abstract <code>MacroCommand</code> implementation.
	 * 
	 * @author r.moorman
	 */
	public class MacroCommand extends Command
	{
		[Inject]
		/**
		 * 
		 */
		public var reflector: IReflector;
		
		/**
		 * @private
		 */
		private var commands: Vector.<Command>;
		
		/**
		 * @private
		 */
		private var events: Vector.<Event>;
		
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
			events = ClassUtil.getEventsFromObject( reflector, this );
			
			var event: Event;
			
			for each( event in events )
				injector.mapValue( getDefinitionByName( getQualifiedClassName( event )) as Class, event );
			
			initializeMacroCommandCommand();
			
			for each( event in events )
				injector.unmap( getDefinitionByName( getQualifiedClassName( event )) as Class );
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
		protected function initializeMacroCommandCommand(): void
		{
			
		}
	}
}