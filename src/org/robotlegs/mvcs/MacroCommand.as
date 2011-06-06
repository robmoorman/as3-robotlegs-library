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
	 * https://github.com/moorinteractive/as3-robotlegs-library/wiki/macrocommand
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
		private var commandClasses: Vector.<Class>;
		
		/**
		 * @private
		 */
		private var events: Vector.<Event>;
		
		/**
		 * Constructor. 
		 */
		public function MacroCommand()
		{
			commandClasses = new Vector.<Class>;
		}
		
		/**
		 * 
		 */
		final override public function execute(): void
		{
			events = ClassUtil.getEventsFromObject( reflector, this );
			
			var event: Event;
			
			for each( event in events )
				injector.mapValue( getDefinitionByName( getQualifiedClassName( event )) as Class, event );
			
			while( commandClasses.length ) {
				var command: Command = injector.instantiate( commandClasses.shift() as Class ) as Command;
				command.execute();
			}
			
			for each( event in events )
				injector.unmap( getDefinitionByName( getQualifiedClassName( event )) as Class );
		}
		
		[PostConstruct]
		/**
		 * 
		 */
		final public function onPostConstruct(): void
		{
			initializeMacroCommandCommand();
		}
		
		/**
		 * 
		 * 
		 * @param commandClass
		 */
		final protected function addSubCommand( commandClass: Class ): void
		{
			commandClasses.push( commandClass );
		}
		
		/**
		 * 
		 */
		protected function initializeMacroCommandCommand(): void
		{
			
		}
	}
}