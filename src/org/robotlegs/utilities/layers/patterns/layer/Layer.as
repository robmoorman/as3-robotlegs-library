package org.robotlegs.utilities.layers.patterns.layer
{
	import flash.display.Sprite;
	
	/**
	 * Abstract implementation of <code>IAsset</code>.
	 * 
	 * @author r.moorman
	 */
	public class Layer extends Sprite implements ILayer
	{
		/**
		 * Constructor.
		 * 
		 * @param name The name of the <code>Layer</code>.
		 */
		public function Layer( name: String )
		{
			super();
			
			this.name = name;
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.patterns.layer.ILayer.lock()
		 */
		public function lock(): void
		{
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		/**
		 * @copy org.robotlegs.utilities.layers.patterns.layer.ILayer.unlock()
		 */
		public function unlock(): void
		{
			mouseChildren = true;
			mouseEnabled = true;
		}
	}
}