package org.robotlegs.mvcs
{
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.core.IASyncCommand;
	import org.robotlegs.core.IReflector;
	import org.robotlegs.utils.ClassUtil;

	/**
	 * Abstract <code>ASyncMacroCommand</code> implementation.
	 * 
	 * @author r.moorman
	 */
	public class ASyncMacroCommand extends Command implements IASyncCommand
	{
		[Inject]
		/**
		 * 
		 */
		public var reflector: IReflector;
		
		/**
		 * @private
		 */
		private var onComplete: Function;
		
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
		public function ASyncMacroCommand()
		{
			commandClasses = new Vector.<Class>;
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
			events = ClassUtil.getEventsFromObject( reflector, this );
			
			var event: Event;
			
			for each( event in events )
				injector.mapValue( getDefinitionByName( getQualifiedClassName( event )) as Class, event );
			
			if( commandClasses.length ) {
				var command: Command = injector.instantiate( commandClasses.shift() as Class ) as Command;
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
			commandClasses.push( commandClass );
		}
		
		/**
		 * 
		 */
		protected function initializeASyncMacroCommand(): void
		{
			
		}
	}
}