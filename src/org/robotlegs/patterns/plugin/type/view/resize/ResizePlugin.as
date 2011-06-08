package org.robotlegs.patterns.plugin.type.view.resize
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import org.robotlegs.patterns.plugin.type.view.IViewPlugin;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class ResizePlugin implements IViewPlugin
	{
		[Inject]
		/**
		 * 
		 */
		public var contextView: DisplayObjectContainer;
		
		/**
		 * @private
		 */
		private var _resizeMap: Dictionary;
		
		/**
		 * @constructor
		 */
		public function ResizePlugin()
		{
			_resizeMap = new Dictionary;
		}
		
		[PostConstruct]
		/**
		 * 
		 */
		public function initialize(): void
		{
			contextView.stage.addEventListener( Event.RESIZE, onResize, false, 0, true );
		}
		
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.addedToStage()
		 */
		public function addedToStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is IResize ) {
				_resizeMap[ target.name ] = target;
				
				( target as IResize ).resize( stage.stageWidth, stage.stageHeight );
			}
		}
		
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.addedToStage()
		 */
		public function removedFromStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is IResize ) {
				delete _resizeMap[ target.name ];
			}
		}
		
		/**
		 * 
		 * 
		 * @param evt
		 */
		protected function onResize( evt: Event ): void
		{
			var resize: IResize;
			
			for each( resize in _resizeMap ) {
				resize.resize( contextView.stage.stageWidth, contextView.stage.stageHeight );
			}
		}
	}
}