package org.robotlegs.utils
{
	import flash.events.Event;
	import flash.utils.describeType;
	
	import org.robotlegs.core.IReflector;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class ClassUtil
	{
		/**
		 * 
		 * 
		 * @param reflector
		 * @param value
		 * @return 
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