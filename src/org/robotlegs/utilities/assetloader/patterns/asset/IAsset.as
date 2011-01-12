package org.robotlegs.utilities.assetloader.patterns.asset
{
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public interface IAsset
	{
		/**
		 * 
		 */
		function get id(): String;
		
		/**
		 * 
		 */
		function get url(): String;
		
		/**
		 * @private
		 */
		function set url( value: String ): void;
		
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
		function get data(): Object;
		
		/**
		 * 
		 */
		function get bytesLoaded(): uint;
		
		/**
		 * 
		 */
		function get bytesTotal(): uint;
		
		/**
		 * 
		 */
		function get percentage(): Number;
		
		/**
		 * 
		 */
		function load(): void;
		
		/**
		 * 
		 */
		function dispose(): void;
		
		/**
		 * 
		 * 
		 * @param value
		 */
		function setOnComplete( value: Function ): void;
		
		/**
		 * 
		 * 
		 * @param value
		 */
		function setOnProgress( value: Function ): void;
		
		/**
		 * 
		 * 
		 * @param value
		 */
		function setOnError( value: Function ): void;
	}
}