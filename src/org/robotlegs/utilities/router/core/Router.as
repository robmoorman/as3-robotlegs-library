package org.robotlegs.utilities.router.core
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.utilities.router.events.RouterEvent;
	import org.robotlegs.utilities.router.patterns.route.Route;

	/**
	 * Abstract <code>MacroCommand</code> implementation.
	 * 
	 * @author r.moorman
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/router
	 */
	public class Router extends Actor implements IRouter
	{
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.history
		 */	
		public function get history(): Array {
			return _history;
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.active
		 */	
		public function get active(): Boolean {
			return _active;
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.pathNames
		 */	
		public function get pathNames(): Array {
			return SWFAddress.getPathNames();
		}
		
		/**
		 * @private
		 */
		private var _history: Array;
		
		/**
		 * @private
		 */
		private var _active: Boolean;
		
		/**
		 * @private
		 */
		private var _routes: Vector.<Route>;
		
		/**
		 * Constructor.
		 */
		public function Router()
		{
			super();
			
			_history = [];
			_active = false;
			_routes = new Vector.<Route>;
			
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, onChange, false, 0, true );
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.activate()
		 */
		public function activate( checkRoutes: Boolean = true ): void
		{
			_active = true;
			
			if( checkRoutes )
				checkRoutesOnAddressChange( SWFAddress.getPathNames().concat());
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.deactivate()
		 */
		public function deactivate(): void
		{
			_active = false;
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.addRoute()
		 */
		public function addRoute( type: String, commandClass: Class = null ): Route
		{
			var route: Route = new Route( type );
			
			_routes.push( route );
			_routes.sort( sortRoutes );
			
			if( commandClass ) {
				dispatch( new RouterEvent( RouterEvent.MAP_EVENT_TO_ROUTE, { type:type, commandClass:commandClass }));
			}
			
			return route;
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.removeRoute()
		 */
		public function removeRoute( type: String, commandClass: Class ): void
		{
			var route: Route;
			
			for each( route in _routes ) {
				if( route.type === type ) {
					_routes.splice( _routes.indexOf( route ), 1 );
				}
			}
			
			_routes.sort( sortRoutes );
			
			if( commandClass ) {
				dispatch( new RouterEvent( RouterEvent.REMOVE_EVENT_FROM_ROUTE, { type:type, commandClass:commandClass }));
			}
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.changeAddress()
		 */
		public function changeAddress( value: String ): void
		{
			SWFAddress.setValue( value );
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.changeAddressOnly()
		 */
		public function changeAddressOnly( value: String ): void
		{
			deactivate();
			
			SWFAddress.setValue( value );
			
			activate( false );
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.core.IRouter.changeBrowserTitle()
		 */
		public function changeBrowserTitle( value: String ): void
		{
			SWFAddress.setTitle( value );
		}
		
		/**
		 * 
		 * 
		 * @param x
		 * @param y
		 * @return 
		 */
		private function sortRoutes( x: Route, y: Route ): Number
		{
			if( x.length > y.length )
				return -1;
			else if( x.length == y.length )
				return 0;
			else
				return 1;
		}
		
		/**
		 * 
		 * 
		 * @param pathNames
		 */
		private function checkRoutesOnAddressChange( pathNames: Array ): void
		{
			if( !_active )
				return;
			
			_routes = _routes.sort( sortRoutes );
			
			var route: Route = getMatchedRoute( pathNames );
			
			if( !route || !pathNames || !pathNames.length ) {
				dispatch( new RouterEvent( RouterEvent.NO_ROUTE_FOUND, pathNames ));
			}
			else {
				_history.push( '/' + pathNames.join( '/' ) + '/' );
				
				dispatch( new RouterEvent( route.type, route.getPayload( pathNames )));
			}
		}
		
		/**
		 * 
		 * 
		 * @param pathNames
		 * @return 
		 */
		private function getMatchedRoute( pathNames: Array ): Route
		{
			var route: Route;
			
			for each( route in _routes )
				if( route.match( pathNames ))
					return route;
			
			return null;
		}
		
		/**
		 * 
		 * 
		 * @param evt
		 */
		private function onChange( evt: SWFAddressEvent ): void
		{
			checkRoutesOnAddressChange( evt.pathNames );
		}
	}
}