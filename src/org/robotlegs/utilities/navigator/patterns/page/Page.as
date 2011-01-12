package org.robotlegs.utilities.navigator.patterns.page
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * Abstract <code>Page</code> implementation.
	 * 
	 * @author r.moorman
	 */
	public class Page extends Sprite implements IPage
	{
		/**
		 * @copy org.robotlegs.utilities.navigator.patterns.page.IPage.content
		 */
		public function get content(): DisplayObject {
			return this;
		}
		
		/**
		 * Constructor.
		 */
		public function Page( name: String )
		{
			super();
			
			this.name = name;
		}
	}
}