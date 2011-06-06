package org.robotlegs.utilities.router.patterns.route
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import org.robotlegs.utilities.router.patterns.pattern.IPattern;
	import org.robotlegs.utilities.router.patterns.pattern.Pattern;

	/**
	 * Abstract <code>Route</code> implementation.
	 * 
	 * @author r.moorman
	 */
	dynamic public class Route extends Proxy
	{
		/**
		 * 
		 * 
		 * @return 
		 */
		public function get type(): String {
			return _type;
		}
		
		/**
		 * 
		 * 
		 * @return 
		 */
		public function get length(): int {	
			return _patterns.length;
		}
		
		/**
		 * @private
		 */
		private var _type: String;
		
		/**
		 * @private
		 */
		private var _patterns: Vector.<IPattern>;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 */
		public function Route( type: String )
		{
			super();
			
			_type = type;
			_patterns = new Vector.<IPattern>;
		}
		
		/**
		 * 
		 * 
		 * @param pathNames
		 * @return 
		 */
		public function match( pathNames: Array ): Boolean
		{
			var i: int;
			var pattern: IPattern;
			
			for( i = 0; i < _patterns.length; i++ )
				if( !_patterns[ i ].match( pathNames[ i ] ? pathNames[ i ].toString() : null ))
					return false;
			
			return pathNames.length ? true : false;
		}
		
		/**
		 * 
		 * 
		 * @param pathNames
		 * @return 
		 */
		public function getPayload( pathNames: Array ): Object
		{
			var pattern: IPattern;
			var payload: Object = {};
			
			for each( pattern in _patterns )
				payload[ pattern.name ] = pattern.value;
			
			return payload;
		}
		
		/**
		 * 
		 * 
		 * @return
		 */
		public function toString(): String
		{
			return '[Route type="' + type + '"]';
		}
		
		/**
		 * 
		 * 
		 * @param name
		 * @param parameters
		 * @return 
		 */
		override flash_proxy function callProperty( name: *, ...parameters ): *
		{
			var pattern: IPattern;
			var value: Object = parameters[ 0 ];
			
			if( value is String )
				pattern = new Pattern( name, new RegExp( value ));
			else if( value is RegExp )
				pattern = new Pattern( name, value as RegExp );
			else
				pattern = new Pattern( name );
			
			_patterns.push( pattern );
			
			return this;
		}
	}
}