package org.robotlegs.utilities.assetloader.patterns.asset
{
	import flash.events.IEventDispatcher;
	/**
	 * The interface definition for an <code>Asset</code>.
	 * 
	 * @author r.moorman
	 */
	public interface IAsset extends IEventDispatcher
	{
		/**
		 * The unique id of the <code>Asset</code>.
		 */
		function get id(): String;
		
		/**
		 * The url of the <code>Asset</code>.
		 */
		function get url(): String;
		
		/**
		 * @private
		 */
		function set url( value: String ): void;
		
		/**
		 * Optional closure method for retrieving <code>AssetLoaderEvents</code>.
		 */
		function get closure(): Function;
		
		/**
		 * @private
		 */
		function set closure( value: Function ): void;
		
		/**
		 * The current state of the <code>Asset</code>.
		 * 
		 * @see org.robotlegs.utilities.assetloader.core.AssetLoaderState
		 */
		function get state(): String;
		
		/**
		 * The raw loaded data of the <code>Asset</code>.
		 */
		function get data(): Object;
		
		/**
		 * The current loaded bytes of the <code>Asset</code>.
		 */
		function get bytesLoaded(): uint;
		
		/**
		 * The total bytes to load of the <code>Asset</code>.
		 */
		function get bytesTotal(): uint;
		
		/**
		 * The current percentage of the loaded bytes of the <code>Asset</code> (from 0 till 100).
		 */
		function get percentage(): Number;
		
		/**
		 * Trigger the <code>Asset</code> to load it's data.
		 */
		function load(): void;
		
		/**
		 * Trigger the <code>Asset</code> to dispose it's references.
		 */
		function dispose(): void;
		
		/**
		 * Set the callback method after the <code>Asset</code> is successfully loaded.
		 * 
		 * @param value The callback method to be called.
		 */
		function setOnComplete( value: Function ): void;
		
		/**
		 * Set the callback method while the <code>Asset</code> is loading.
		 * 
		 * @param value The callback method to be called.
		 */
		function setOnProgress( value: Function ): void;
		
		/**
		 * Set the callback method after the <code>Asset</code> failed to load.
		 * 
		 * @param value The callback method to be called.
		 */
		function setOnError( value: Function ): void;
	}
}