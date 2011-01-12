package org.robotlegs.utilities.router.controller.route
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.router.error.RouterError;
	import org.robotlegs.utilities.router.events.RouterEvent;

	/**
	 * Map a <code>Command</code> to a specific <code>Route</code>.
	 * 
	 * @author r.moorman
	 */
	public class MapEventToRouteCommand extends Command
	{
		[Inject]
		/**
		 * 
		 */
		public var event: RouterEvent;
		
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			var payload: Object = event.payload;
			
			if( payload.hasOwnProperty( 'type' ) && payload.hasOwnProperty( 'commandClass' )) {
				var type: String = payload.type;
				var commandClass: Class = payload.commandClass;
				
				commandMap.mapEvent( type, commandClass, RouterEvent );
			}
			else
				throw new RouterError( 'Payload must contain properties type and commandClass!' );
		}
	}
}