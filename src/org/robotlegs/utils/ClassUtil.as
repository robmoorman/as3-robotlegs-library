package org.robotlegs.utils
{
	import flash.events.Event;
	import flash.utils.describeType;
	
	import org.robotlegs.core.IReflector;
	
	/**
	 * Utilities for <code>Class</code> related functionalities.
	 * 
	 * @author r.moorman
	 */
	public class ClassUtil
	{
		/**
		 * Get all <code>Events</code> form a provided value.
		 * 
		 * <p>This method is usually called by a <code>MacroCommand</code> for passing through
		 * it's <code>Events</code> to <code>SubCommands</code>.</p>
		 * 
		 * @param reflector The <code>IReflector</code> of Robotlegs.
		 * @param value The value to get the Events from.
		 * @return Vector instance of all Events found in the provided value.
		 */
		public static function getEventsFromObject( reflector: IReflector, value: Object ): Vector.<Event>
		{
			var node: XML;
			var name: String;
			var type: String;
			var events: Vector.<Event> = new Vector.<Event>;
			var description: XML = describeType( value );
			
			for each( node in description.*.( name() == 'variable' || name() == 'accessor' ).metadata.( @name == 'Inject' )) {
				type = node.parent().@type.toString();
				
				if( reflector.classExtendsOrImplements( type, Event )) {
					name = node.parent().@name.toString();
					
					events.push( value[ name ]);
				}
			}
			
			return events;
		}
	}
}