package org.robotlegs.patterns.plugin.type.view.autoload
{
	import flash.display.Sprite;

	/**
	 * @author koert
	 */
	public class AbstractAutoLoad extends Sprite implements IAutoLoad
	{
		
		protected var _isLoaded : Boolean = false;
		protected var _url : String;
		
		public function AbstractAutoLoad( url:String ) {
			_url = url;
		}
		
		public function callBack(payLoad : Object) : void
		{
			
		}

		public function get url() : String
		{
			return _url;
		}

		public function get isLoaded() : Boolean
		{
			return _isLoaded;
		}

		public function set isLoaded(value : Boolean) : void
		{
			_isLoaded = value;
		}
	}
}
