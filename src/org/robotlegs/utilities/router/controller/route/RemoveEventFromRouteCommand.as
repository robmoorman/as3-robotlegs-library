package org.robotlegs.utilities.router.controller.route
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.router.error.RouterError;
	import org.robotlegs.utilities.router.events.RouterEvent;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class RemoveEventFromRouteCommand extends Command
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
				
				commandMap.unmapEvent( type, commandClass, RouterEvent );
			}
			else
				throw new RouterError( 'Payload must contain properties type and commandClass!' );
		}
	}
}