package org.robotlegs.utilities.layers.patterns.layer
{
	import flash.display.Sprite;

	public class Layer extends Sprite implements ILayer
	{
		public function Layer( name: String )
		{
			super();
			
			this.name = name;
		}
		
		public function lock(): void
		{
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		public function unlock(): void
		{
			mouseChildren = true;
			mouseEnabled = true;
		}
	}
}