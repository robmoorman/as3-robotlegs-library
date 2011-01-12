package org.robotlegs.utilities.assetloader.events
{
	import flash.events.Event;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	import org.robotlegs.utilities.assetloader.patterns.group.IGroup;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class AssetLoaderEvent extends Event
	{
		/**
		 * Dispatched when.
		 */
		public static const ASSET_COMPLETE: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.ASSET_COMPLETE';
		
		/**
		 * Dispatched when.
		 */
		public static const ASSET_PROGRESS: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.ASSET_PROGRESS';
		
		/**
		 * Dispatched when.
		 */
		public static const ASSET_ERROR: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.ASSET_ERROR';
		
		/**
		 * Dispatched when.
		 */
		public static const GROUP_COMPLETE: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.GROUP_COMPLETE';
		
		/**
		 * Dispatched when.
		 */
		public static const GROUP_PROGRESS: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.GROUP_PROGRESS';
		
		/**
		 * Dispatched when.
		 */
		public static const GROUP_ERROR: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.GROUP_ERROR';
		
		/**
		 * 
		 */
		public function get asset(): IAsset {
			return _asset;
		}
		
		/**
		 * @private
		 */
		public function set asset( value: IAsset ): void {
			_asset = value;
		}
		
		/**
		 * 
		 */
		public function get group(): IGroup {
			return _group;
		}
		
		/**
		 * @private
		 */
		public function set group( value: IGroup ): void {
			_group = value;
		}
		
		/**
		 * @private
		 */
		private var _asset: IAsset;
		
		/**
		 * @private
		 */
		private var _group: IGroup;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param asset
		 * @param group
		 * @param bubbles
		 * @param cancelable
		 */
		public function AssetLoaderEvent( type: String, asset: IAsset = null, group: IGroup = null, bubbles: Boolean = false, cancelable: Boolean = false )
		{
			super( type, bubbles, cancelable );
			
			_asset = asset;
			_group = group;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): Event
		{
			return new AssetLoaderEvent( type, asset, group, bubbles, cancelable );
		}
	}
}