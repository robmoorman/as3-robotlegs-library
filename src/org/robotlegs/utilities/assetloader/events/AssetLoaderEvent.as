package org.robotlegs.utilities.assetloader.events
{
	import flash.events.Event;
	
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	import org.robotlegs.utilities.assetloader.patterns.group.IGroup;

	/**
	 * Custom <code>Event</code> for <code>AssetLoader</code>.
	 * 
	 * @author r.moorman
	 */
	public class AssetLoaderEvent extends Event
	{
		/**
		 * Dispatched when an <code>Asset</code> is successfully loaded.
		 */
		public static const ASSET_COMPLETE: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.ASSET_COMPLETE';
		
		/**
		 * Dispatched while an <code>Asset</code> is loading.
		 */
		public static const ASSET_PROGRESS: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.ASSET_PROGRESS';
		
		/**
		 * Dispatched when an <code>Asset</code> failed to load (due a illegal operation or a security error).
		 */
		public static const ASSET_ERROR: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.ASSET_ERROR';
		
		/**
		 * Dispatched when a <code>Group</code> is successfully loaded.
		 */
		public static const GROUP_COMPLETE: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.GROUP_COMPLETE';
		
		/**
		 * Dispatched while a <code>Group</code> is loading.
		 * 
		 * <p>While a <code>Group</code> is loading, it's <code>Assets</code> will be dispatched during this progress, so you
		 * are able to handle completed <code>Assets</code> before the whole <code>Group</code> is loaded (performance better wise).</p>
		 */
		public static const GROUP_PROGRESS: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.GROUP_PROGRESS';
		
		/**
		 * Dispatched when a <code>Group</code> failed to load (due a illegal operation or a security error).
		 */
		public static const GROUP_ERROR: String = 'org.robotlegs.utilities.assetloader.events.AssetLoaderEvent.GROUP_ERROR';
		
		/**
		 * The <code>Asset</code> that triggered this <code>Event</code>.
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
		 * The optional <code>Group</code> that triggered this <code>Event</code>.
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
		 * @param type The type of <code>Event</code>.
		 * @param asset The <code>Asset</code> that triggered this <code>Event</code>.
		 * @param group The optional <code>Group</code> that triggered this <code>Event</code>.
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