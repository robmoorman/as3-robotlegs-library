package org.robotlegs.base
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IPluginMap;
	import org.robotlegs.patterns.plugin.IPlugin;
	
	public class PluginMap extends ViewMapBase implements IPluginMap
	{
		protected var _pluginMap: Dictionary;
		
		public function PluginMap( contextView: DisplayObjectContainer, injector: IInjector )
		{
			super( contextView, injector );
			
			_pluginMap = new Dictionary;
		}
		
		public function addPlugin( id: String, pluginClass: Class ): void
		{
			if( _pluginMap[ id ]) {
				return;
			}
			
			_pluginMap[ id ] = injector.instantiate( pluginClass );
			
			viewListenerCount++;
			
			if( viewListenerCount == 1 ) {
				addListeners();
			}
		}
		
		public function removePlugin( id: String ): IPlugin
		{
			var plugin: IPlugin = _pluginMap[ id ];
			
			delete _pluginMap[ id ];
			
			if( plugin ) {
				viewListenerCount--;
				
				if( viewListenerCount == 0 ) {
					removeListeners();
				}
			}
			
			return plugin;
		}
		
		public function hasPlugin( id: String ): Boolean
		{
			return _pluginMap[ id ] != null;
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
				plugin.addedToStage( contextView.stage, evt.target as DisplayObject );
			}
		}
		
		protected function onViewRemoved( evt: Event ): void
		{
			var plugin: IPlugin;
			
			for each( plugin in _pluginMap ) {
				plugin.removedFromStage( contextView.stage, evt.target as DisplayObject );
			}
		}
	}
}