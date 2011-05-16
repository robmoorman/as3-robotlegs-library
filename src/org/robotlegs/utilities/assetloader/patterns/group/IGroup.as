package org.robotlegs.utilities.assetloader.patterns.group
{
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;

	/**
	 * The interface definition for a <code>Group</code>.
	 * 
	 * @author r.moorman
	 */
	public interface IGroup
	{
		/**
		 * The unique id of the <code>Group</code>.
		 */
		function get id(): String;
		
		/**
		 * @private
		 */
		function set id( value: String ): void;
		
		/**
		 * The assets of the <code>Group</code>.
		 */
		function get assets(): Vector.<IAsset>;
		
		/**
		 * @private
		 */
		function set assets( value: Vector.<IAsset> ): void;
		
		/**
		 * The max connections before a next <code>Asset</code> in the queue starts loading.
		 */
		function get maxConnections(): int;
		
		/**
		 * @private
		 */
		function set maxConnections( value: int ): void;
		
		/**
		 * Optional closure method for retrieving <code>AssetLoaderEvents</code>.
		 */
		function get closure(): Function;
		
		/**
		 * @private
		 */
		function set closure( value: Function ): void;
		
		/**
		 * The current state of the <code>Group</code>.
		 * 
		 * @see org.robotlegs.utilities.assetloader.core.AssetLoaderState
		 */
		function get state(): String;
		
		/**
		 * The current total loaded bytes of the <code>Group</code> (from 0 till 100).
		 */
		function get bytesLoaded(): uint;
		
		/**
		 * The total bytes to load of the <code>Group</code>.
		 */
		function get bytesTotal(): uint;
		
		/**
		 * The current percentage of the total loaded bytes of the <code>Group</code>.
		 */
		function get percentage(): Number;
		
		/**
		 * Trigger the <code>Group</code> to load it's <code>Assets</code>.
		 */
		function load(): void;
		
		/**
		 * Trigger the <code>Group</code> to dispose it's references.
		 */
		function dispose(): void;
	}
}