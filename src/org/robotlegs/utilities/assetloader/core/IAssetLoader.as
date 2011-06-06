package org.robotlegs.utilities.assetloader.core
{
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	import org.robotlegs.utilities.assetloader.patterns.group.IGroup;
	import flash.system.LoaderContext;

	/**
	 * The interface definition for <code>AssetLoader</code>.
	 * 
	 * @author r.moorman
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/assetloader
	 */
	public interface IAssetLoader
	{
		/**
		 * Set an optional base url as a prefix for all <code>Assets</code>.
		 * 
		 * <p>If the requiest url of an <code>Asset</code> contains 'http://'
		 * the base url will not be added to the url.</p>
		 */
		function get baseUrl(): String;
		
		/**
		 * @private
		 */
		function set baseUrl( value: String ): void;
		
		/**
		 * Set an optional <code>LoaderContext</code> for all <code>Assets</code>
		 * which are loading their data via the <code>Loader</code>.
		 */
		function get loaderContext(): LoaderContext;
		
		/**
		 * @private
		 */
		function set loaderContext( value: LoaderContext ): void;
		
		/**
		 * Load a single <code>Asset</code>.
		 * 
		 * <p>The <code>AssetLoader</code> automatically assigns the
		 * right asset class by checking the extension of the asset.
		 * The following type's are currently supported:</p>
		 * 
		 * <ul>
		 * 	<li><code>BitmapAsset</code> (png, gif, jpg and jpeg)</li>
		 * 	<li><code>DisplayObjectAsset</code> (swf)</li>
		 * 	<li><code>SoundAsset</code> (mp3, wav, aif)</li>
		 * 	<li><code>CSSAsset</code> (css)</li>
		 * 	<li><code>XMLAsset</code> (xml)</li>
		 * </ul>
		 *
		 * <p>For assigning custom types of <code>Assets</code> you can
		 * use the method <code>addAssetClass</code>.</p>
		 * 
		 * @param request The url of the <code>Asset</code> as a <code>String</code>.
		 * @param closure Optional closure method for retrieving <code>AssetLoaderEvents</code>.
		 * @return A new instance of <code>Asset</code>.
		 *
		 * @see org.robotlegs.utilities.assetloader.core.IAssetLoader.addAssetClass()
		 */
		function load( request: Object, closure: Function = null ): IAsset;
		
		/**
		 * Load a group of <code>Assets</code>.
		 * 
		 * @param request The urls of the <code>Assets</code> as an <code>Array</code> or <code>Vector</code> of <code>Strings</code>.
		 * @param closure Optional closure method for retrieving <code>AssetLoaderEvents</code>.
		 * @return A new instance of <code>Group</code>.
		 * @see org.robotlegs.utilities.assetloader.core.IAssetLoader.load()
		 */
		function loadGroup( request: Object, closure: Function = null ): IGroup;
		
		/**
		 * Get an <code>Asset</code> by it's id.
		 * 
		 * @param id The id of the <code>Asset</code>.
		 * @return An instance of <code>Asset</code>, <code>null</code> if not found.
		 */
		function getAsset( id: String ): IAsset;
		
		/**
		 * Check if an <code>Asset</code> exists under an id.
		 * 
		 * @param id The id of the <code>Asset</code>.
		 * @return <code>True</code> or <code>False</code>.
		 */
		function hasAsset( id: String ): Boolean;
		
		/**
		 * Remove an <code>Asset</code> by it's id.
		 * 
		 * @param id The id of the <code>Asset</code>.
		 */
		function removeAsset( id: String ): void;
		
		/**
		 * Get an <code>Asset</code> by it's url.
		 * 
		 * @param url The url of the <code>Asset</code>.
		 * @return An instance of <code>Asset</code>, <code>null</code> if not found.
		 */
		function getAssetByUrl( url: String ): IAsset;
		
		/**
		 * Check if an <code>Asset</code> exists under an url.
		 * 
		 * @param url The url of the <code>Asset</code>.
		 * @return <code>True</code> or <code>False</code>.
		 */
		function hasAssetByUrl( url: String ): Boolean;
		
		/**
		 * Remove an <code>Asset</code> by it's url.
		 * 
		 * @param url The url of the <code>Asset</code>.
		 */
		function removeAssetByUrl( url: String ): void;
		
		/**
		 * Get a <code>Group</code> by it's id.
		 * 
		 * @param id The id of the <code>Group</code>.
		 * @return An instance of <code>Group</code>, <code>null</code> if not found.
		 */
		function getGroup( id: String ): IGroup;
		
		/**
		 * Check if a <code>Group</code> exists under an id.
		 * 
		 * @param id The id of the <code>Group</code>.
		 * @return <code>True</code> or <code>False</code>.
		 */
		function hasGroup( id: String ): Boolean;
		
		/**
		 * Remove a <code>Group</code> by it's id.
		 * 
		 * @param id The id of the <code>Group</code>.
		 */
		function removeGroup( id: String ): void;
		
		/**
		 * Assign a custom type of <code>Asset</code>.
		 * 
		 * @param contains The value that should be available in the url (case-sensitive).
		 * @param assetClass The type of <code>IAsset</code> that should be instantiated when the value in the url is available.
		 */
		function addAssetClass( contains: String, assetClass: Class ): void;
	}
}