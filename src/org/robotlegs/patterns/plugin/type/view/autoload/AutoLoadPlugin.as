package org.robotlegs.patterns.plugin.type.view.autoload
{
	import org.robotlegs.patterns.plugin.type.view.IViewPlugin;
	import org.robotlegs.utilities.assetloader.core.IAssetLoader;
	import org.robotlegs.utilities.assetloader.events.AssetLoaderEvent;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.utils.Dictionary;

	/**
	 * @author koert
	 */
	public class AutoLoadPlugin implements IViewPlugin
	{
		
		[Inject]
		public var loader:IAssetLoader;

		[Inject]
		public var contextView: DisplayObjectContainer;
		
		protected var callBacks:Dictionary= new Dictionary();
		
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.addedToStage()
		 */
		public function addedToStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is AbstractAutoLoad ) {
				var iLoad:AbstractAutoLoad = (target as AbstractAutoLoad);
				
				if(iLoad.isLoaded)
					return;
					
				callBacks[ iLoad.url ] = iLoad;
				loader.load( iLoad.url ,onLoadProcess);
			}
		}
		
		private function onLoadProcess(e : AssetLoaderEvent):void {
			if(e.type == AssetLoaderEvent.ASSET_COMPLETE )
			{
				(callBacks[ e.asset.url ] as AbstractAutoLoad).callBack(e.asset.data);
				(callBacks[ e.asset.url ] as AbstractAutoLoad).isLoaded = true;
			}
		}
		
		/**
		 * @copy org.robotlegs.patterns.plugin.type.view.IViewPlugin.addedToStage()
		 */
		public function removedFromStage( stage: Stage, target: DisplayObject ): void
		{
			if( target is AbstractAutoLoad ) {
				var iLoad:AbstractAutoLoad = (target as AbstractAutoLoad);
				callBacks[ iLoad.url ] = null;
			}
		}
	}
}
