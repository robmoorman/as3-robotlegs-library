package org.robotlegs.utilities.assetloader.core
{
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	import org.robotlegs.utilities.assetloader.patterns.group.IGroup;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public interface IAssetLoader
	{
		/**
		 * 
		 * 
		 * @param request
		 * @param closure
		 * @return 
		 */
		function load( request: Object, closure: Function = null ): IAsset;
		
		/**
		 * 
		 * 
		 * @param request
		 * @param closure
		 * @return 
		 */
		function loadGroup( request: Object, closure: Function = null ): IGroup;
		
		/**
		 * 
		 * 
		 * @param id
		 * @return 
		 */
		function getAsset( id: String ): IAsset;
		
		/**
		 * 
		 * 
		 * @param id
		 * @return 
		 */
		function hasAsset( id: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param id
		 */
		function removeAsset( id: String ): void;
		
		/**
		 * 
		 * 
		 * @param url
		 * @return 
		 */
		function getAssetByUrl( url: String ): IAsset;
		
		/**
		 * 
		 * 
		 * @param url
		 * @return 
		 */
		function hasAssetByUrl( url: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param url
		 */
		function removeAssetByUrl( url: String ): void;
		
		/**
		 * 
		 * 
		 * @param id
		 * @return 
		 */
		function getGroup( id: String ): IGroup;
		
		/**
		 * 
		 * 
		 * @param id
		 * @return 
		 */
		function hasGroup( id: String ): Boolean;
		
		/**
		 * 
		 * 
		 * @param id
		 */
		function removeGroup( id: String ): void;
	}
}