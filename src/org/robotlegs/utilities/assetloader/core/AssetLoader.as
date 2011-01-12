package org.robotlegs.utilities.assetloader.core
{
	import flash.utils.Dictionary;
	
	import org.robotlegs.utilities.assetloader.error.AssetLoaderError;
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	import org.robotlegs.utilities.assetloader.patterns.group.Group;
	import org.robotlegs.utilities.assetloader.patterns.group.IGroup;
	import org.robotlegs.utilities.assetloader.utils.AssetUtil;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class AssetLoader implements IAssetLoader
	{
		/**
		 * @private
		 */
		private var _assetIds: int;
		
		/**
		 * @private
		 */
		private var _assetMap: Dictionary;
		
		/**
		 * @private
		 */
		private var _assetMapByUrl: Dictionary;
		
		/**
		 * @private
		 */
		private var _groupMap: Dictionary;
		
		/**
		 * Constructor.
		 */
		public function AssetLoader()
		{
			super();
			
			_assetIds = 0;
			_assetMap = new Dictionary;
			_assetMapByUrl = new Dictionary( true );
			_groupMap = new Dictionary;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.load();
		 */
		public function load( request: Object, closure: Function = null ): IAsset
		{
			var url: String;
			var asset: IAsset;
			
			if( request is String )
				asset = instantiateAsset( request.toString());
			else
				throw new AssetLoaderError( 'Request property is not of type String' );
			
			asset.closure = closure;
			asset.load();
			
			return asset;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.loadGroup();
		 */
		public function loadGroup( request: Object, closure: Function = null ): IGroup
		{
			var urls: Vector.<String>;
			var group: IGroup;
			
			if( request is Array )
				group = instantiateGroup( Vector.<String>( request ));
			else if( request is Vector.<String> )
				group = instantiateGroup( request as Vector.<String> );
			else
				throw new AssetLoaderError( 'Request property is not of type Array or Vector.<String>' );
			
			group.closure = closure;
			group.load();
			
			return group;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.getAsset();
		 */
		public function getAsset( id: String ): IAsset
		{
			return _assetMap[ id ] as IAsset;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.hasAsset();
		 */
		public function hasAsset( id: String ): Boolean
		{
			return _assetMap[ id ] != null;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.removeAsset();
		 */
		public function removeAsset( id: String ): void
		{
			if( hasAsset( id )) {
				var asset: IAsset = _assetMap[ id ] as IAsset;
				asset.dispose();
				
				_assetMapByUrl[ asset.url ] = null;
			}
			
			_assetMap[ id ] = null;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.getAssetByUrl();
		 */
		public function getAssetByUrl( url: String ): IAsset
		{
			return _assetMapByUrl[ url ] as IAsset;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.hasAssetByUrl();
		 */
		public function hasAssetByUrl( url: String ): Boolean
		{
			return _assetMapByUrl[ url ] != null;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.removeAssetByUrl();
		 */
		public function removeAssetByUrl( url: String ): void
		{
			if( hasAssetByUrl( url ))
				removeAsset( getAssetByUrl( url ).id );
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.getGroup();
		 */
		public function getGroup( id: String ): IGroup
		{
			return _groupMap[ id ] as IGroup;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.hasGroup();
		 */
		public function hasGroup( id: String ): Boolean
		{
			return _groupMap[ id ] != null;
		}
		
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.removeGroup();
		 */
		public function removeGroup( id: String ): void
		{
			if( hasGroup( id )) {
				var group: IGroup = _groupMap[ id ] as IGroup;
				group.dispose();
			}
			
			_groupMap[ id ] = null;
		}
		
		/**
		 * 
		 * 
		 * @param url
		 * @return 
		 */
		protected function instantiateAsset( url: String ): IAsset
		{
			var id: String = ( _assetIds++ ).toString();
			var assetClass: Class = AssetUtil.getAssetClassByExtension( String( url.split( '.' ).pop()).toLowerCase());
			var asset: IAsset = new assetClass( id, url ) as IAsset;
			
			_assetMap[ id ] = asset;
			_assetMapByUrl[ url ] = asset;
			
			return asset;
		}
		
		/**
		 * 
		 * 
		 * @param urls
		 * @return 
		 */
		protected function instantiateGroup( urls: Vector.<String> ): IGroup
		{
			var url: String;
			var assets: Vector.<IAsset> = new Vector.<IAsset>;
			
			for each( url in urls )
				assets.push( instantiateAsset( url ));
			
			var id: String = ( _assetIds++ ).toString();
			var group: IGroup = new Group( id, assets );
			
			_groupMap[ id ] = group;
			
			return group;
		}
	}
}