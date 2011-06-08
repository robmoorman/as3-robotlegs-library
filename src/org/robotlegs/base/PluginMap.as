package org.robotlegs.base
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IPluginMap;
	import org.robotlegs.patterns.plugin.IPlugin;
	import org.robotlegs.patterns.plugin.type.view.IViewPlugin;
	
	public class PluginMap extends ViewMapBase implements IPluginMap
	{
		protected var _pluginMap: Dictionary;
		
		public function PluginMap( contextView: DisplayObjectContainer, injector: IInjector )
		{
			super( contextView, injector );
			
			_pluginMap = new Dictionary;
		}
		
		public function addPlugin( plugin: IPlugin ): void
		{
			var pluginName: String = getQualifiedClassName( plugin );
			
			if( _pluginMap[ pluginName ]) {
				return;
			}
			
			injector.injectInto( plugin );
			
			_pluginMap[ pluginName ] = plugin;
			
			if( plugin is IViewPlugin ) {
				viewListenerCount++;
				
				if( viewListenerCount == 1 ) {
					addListeners();
				}
			}
		}
		
		public function removePlugin( pluginClass: Class ): void
		{
			var pluginName: String = getQualifiedClassName( pluginClass );
			var plugin: IPlugin = _pluginMap[ pluginName ];
			
			delete _pluginMap[ pluginName ];
			
			if( plugin is IViewPlugin ) {
				viewListenerCount--;
				
				if( viewListenerCount == 0 ) {
					removeListeners();
				}
			}
		}
		
		public function hasPlugin( pluginClass: Class ): Boolean
		{
			return _pluginMap[ getQualifiedClassName( pluginClass )] != null;
		}
		
		override protected function addListeners(): void
		{
			if( contextView && enabled ) {
				contextView.addEventListener( Event.ADDED_TO_STAGE, onViewAdded, useCapture, 0, true );
				contextView.addEventListener( Event.REMOVED_FROM_STAGE, onViewRemoved, useCapture, 0, true );
			}
		}
		
		override protected function removeListeners(): void
		{
			if( contextView ) {
				contextView.addEventListener( Event.ADDED_TO_STAGE, onViewAdded, useCapture );
				contextView.addEventListener( Event.REMOVED_FROM_STAGE, onViewRemoved, useCapture );
			}
		}
		
		override protected function onViewAdded( evt: Event ): void
		{
			var plugin: IPlugin;
			
			for each( plugin in _pluginMap ) {
				if( plugin is IViewPlugin ) {
					( plugin as IViewPlugin ).addedToStage( contextView.stage, evt.target as DisplayObject );
				}
			}
		}
		
		protected function onViewRemoved( evt: Event ): void
		{
			var plugin: IPlugin;
			
			for each( plugin in _pluginMap ) {
				if( plugin is IViewPlugin ) {
					( plugin as IViewPlugin ).removedFromStage( contextView.stage, evt.target as DisplayObject );
				}
			}
		}
	}
}