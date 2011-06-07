package org.robotlegs.mvcs
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.adapters.ExtendedInjector;
	import org.robotlegs.base.PluginMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IPluginMap;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class ExtendedContext extends Context
	{
		/**
		 * @inheritDoc
		 */
		override public function set contextView( value: DisplayObjectContainer ): void
		{
			if( _contextView != value ) {
				_pluginMap = null;
			}
			
			super.contextView = value;
		}
		
		/**
		 * The <code>IPluginMap</code> for this <code>IContext</code>
		 */
		protected function get pluginMap(): IPluginMap {
			return _pluginMap ||= new PluginMap( contextView, injector );
		}
		
		/**
		 * @private
		 */
		protected var _pluginMap: IPluginMap;
		
		/**
		 * @inheritDoc
		 */
		public function ExtendedContext( contextView: DisplayObjectContainer = null, autoStartup: Boolean = true )
		{
			super( contextView, autoStartup );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function mapInjections(): void
		{
			super.mapInjections();
			
			injector.mapValue( IPluginMap, pluginMap );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createInjector(): IInjector
		{
			var injector: IInjector = new ExtendedInjector();
			injector.applicationDomain = getApplicationDomainFromContextView();
			
			return injector;
		}
	}
}