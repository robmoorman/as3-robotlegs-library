package org.robotlegs.utilities.assetloader.patterns.group
{
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public interface IGroup
	{
		/**
		 * 
		 */
		function get id(): String;
		
		/**
		 * @private
		 */
		function set id( value: String ): void;
		
		/**
		 * 
		 */
		function get assets(): Vector.<IAsset>;
		
		/**
		 * @private
		 */
		function set assets( value: Vector.<IAsset> ): void;
		
		/**
		 * 
		 */
		function get maxConnections(): int;
		
		/**
		 * @private
		 */
		function set maxConnections( value: int ): void;
		
		/**
		 * 
		 */
		function get closure(): Function;
		
		/**
		 * @private
		 */
		function set closure( value: Function ): void;
		
		/**
		 * 
		 */
		function get state(): String;
		
		/**
		 * 
		 */
		function load(): void;
		
		/**
		 * 
		 */
		function dispose(): void;
	}
}