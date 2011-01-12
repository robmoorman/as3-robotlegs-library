package org.robotlegs.utilities.router.patterns.pattern
{
	/**
	 * Abstract <code>Pattern</code> implementation.
	 * 
	 * @author r.moorman
	 */
	public class Pattern implements IPattern
	{
		/**
		 * @copy org.robotlegs.utilities.router.patterns.pattern.IPattern.name;
		 */
		public function get name(): String {
			return _name;
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.patterns.pattern.IPattern.value;
		 */
		public function get value(): String {
			return _value;
		}
		
		/**
		 * @private
		 */
		private var _name: String;
		
		/**
		 * @private
		 */
		private var _value: String;
		
		/**
		 * @private
		 */
		private var _regExp: RegExp;
		
		/**
		 * Constructor.
		 * 
		 * @param name
		 * @param regExp
		 */
		public function Pattern( name: String, regExp: RegExp = null )
		{
			_name = name;
			_regExp = regExp;
		}
		
		/**
		 * @copy org.robotlegs.utilities.router.patterns.pattern.IPattern.match();
		 */
		public function match( pathName: String ): Boolean
		{
			if( _regExp ) {
				if( _regExp.test( pathName )) {
					_value = pathName;
					
					return true;
				}
				
				_value = null;
				
				return false;
			}
			
			if( !pathName )
				return false;
			else {
				_value = pathName;
				
				return true;
			}
		}
	}
}