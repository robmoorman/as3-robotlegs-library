package org.robotlegs.patterns.plugin.type
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import org.robotlegs.patterns.plugin.IPlugin;

	public class ResizePlugin implements IPlugin
	{
		[Inject]
		public var contextView: DisplayObjectContainer;
		
		private var _resizeMap: Dictionary;
		
		public function ResizePlugin()
		{
			_resizeMap = new Dictionary;
		}
		
		[PostConstruct]
		public function initialize(): void
		{
			contextView.stage.addEventListener( Event.RESIZE, onResize, false, 0, true );
		}
		
		public function addedToStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is IResize ) {
				_resizeMap[ target.name ] = target;
			}
		}
		
		public function removedFromStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is IResize ) {
				delete _resizeMap[ target.name ];
			}
		}
		
		protected function onResize( evt: Event ): void
		{
			var resize: IResize;
			
			for each( resize in _resizeMap ) {
				resize.resize( contextView.stage.stageWidth, contextView.stage.stageHeight );
			}
		}
	}
}