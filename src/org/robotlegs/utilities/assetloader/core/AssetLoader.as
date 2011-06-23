package org.robotlegs.utilities.assetloader.core
{
	import org.robotlegs.utilities.assetloader.error.AssetLoaderError;
	import org.robotlegs.utilities.assetloader.events.AssetLoaderEvent;
	import org.robotlegs.utilities.assetloader.patterns.asset.IAsset;
	import org.robotlegs.utilities.assetloader.patterns.group.Group;
	import org.robotlegs.utilities.assetloader.patterns.group.IGroup;
	import org.robotlegs.utilities.assetloader.utils.AssetUtil;

	import flash.system.LoaderContext;
	import flash.utils.Dictionary;

	/**
	 * This utility allows you to easily load external assets into your application.
	 * 
	 * <p>All the assets which are loaded by the <code>AssetLoader</code> are stored
	 * and can be retrieved at any time. This can be done by retrieving the asset by
	 * it's url or unique id.</p>
	 * 
	 * <p>The <code>AssetLoader</code> also allows you to load a group of assets at once.
	 * Therefore you will get a <code>Group</code> returned instead of an single <code>Asset</code>.
	 * That <code>Group</code> will have as well as the <code>Asset</code> an unique id you can use
	 * to retrieve it at another point within your application.</p>
	 * 
	 * @author r.moorman
	 * @see https://github.com/moorinteractive/as3-robotlegs-library/wiki/assetloader
	 */
	public class AssetLoader implements IAssetLoader
	{
		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.loaderContext
		 */
		public function get loaderContext() : LoaderContext
		{
			return _loaderContext;
		}

		/**
		 * @private
		 */
		public function set loaderContext(value : LoaderContext) : void
		{
			_loaderContext = value;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.baseUrl
		 */
		public function get baseUrl() : String
		{
			return _baseUrl;
		}

		public function set baseUrl(value : String) : void
		{
			_baseUrl = value;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.maxConnections
		 */
		public function set maxConnections(value : int) : void
		{
			_maxConnections = value;
		}

		public function get maxConnections() : int
		{
			return _maxConnections;
		}

		/**
		 * @private
		 */
		private var _maxConnections : int = 2;
		/**
		 * @private
		 */
		private var _baseUrl : String;
		/**
		 * @private
		 */
		private var _assetIds : int;
		/**
		 * @private
		 */
		private var _assetMap : Dictionary;
		/**
		 * @private
		 */
		private var _assetMapByUrl : Dictionary;
		/**
		 * @private
		 */
		private var _groupMap : Dictionary;
		/**
		 * @private
		 */
		private var _assetClassMap : Dictionary;
		/**
		 * @private
		 */
		private var _loaderContext : LoaderContext;
		/**
		 * @private
		 */
		private var currentConnections : int = 2;
		/**
		 * @private
		 */
		private var que : Array = [];

		/**
		 * Constructor.
		 */
		public function AssetLoader()
		{
			super();

			_assetIds = 0;
			_assetMap = new Dictionary;
			_assetMapByUrl = new Dictionary(true);
			_groupMap = new Dictionary;
			_assetClassMap = new Dictionary;
			_loaderContext = null;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.load()
		 */
		public function load(request : Object, closure : Function = null) : IAsset
		{
			var asset : IAsset;

			if ( request is String )
			{
				asset = instantiateAsset(request.toString());
			}
			else
			{
				throw new AssetLoaderError('Request property is not of type String');
			}

			asset.closure = closure;
			addToCue(asset);

			return asset;
		}

		/**
		 * @private
		 */
		private function addToCue(asset : IAsset) : void
		{
			que.push(asset);
			shiftQue();
		}

		/**
		 * @private
		 */
		private function shiftQue() : void
		{
			if (currentConnections == maxConnections || que.length == 0)
				return;
			else
			{
				var asset : IAsset = que.shift();
				asset.addEventListener(AssetLoaderEvent.ASSET_COMPLETE, onAssetComplete, false, 0, true);
				asset.addEventListener(AssetLoaderEvent.ASSET_ERROR, onAssetComplete, false, 0, true);
				asset.load();
				currentConnections++;
			}
		}

		/**
		 * @private
		 */
		private function onAssetComplete(event : AssetLoaderEvent) : void
		{
			currentConnections--;
			var asset : IAsset = event.asset;
			asset.removeEventListener(AssetLoaderEvent.ASSET_COMPLETE, onAssetComplete);
			asset.removeEventListener(AssetLoaderEvent.ASSET_ERROR, onAssetComplete);
			shiftQue();
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.loadGroup()
		 */
		public function loadGroup(request : Object, closure : Function = null) : IGroup
		{
			var urls : Vector.<String>;
			var group : IGroup;

			if ( request is Array )
			{
				group = instantiateGroup(Vector.<String>(request));
			}
			else if ( request is Vector.<String> )
			{
				group = instantiateGroup(request as Vector.<String>);
			}
			else
			{
				throw new AssetLoaderError('Request property is not of type Array or Vector.<String>');
			}

			group.closure = closure;
			group.load();

			return group;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.getAsset()
		 */
		public function getAsset(id : String) : IAsset
		{
			return _assetMap[ id ] as IAsset;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.hasAsset()
		 */
		public function hasAsset(id : String) : Boolean
		{
			return _assetMap[ id ] != null;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.removeAsset()
		 */
		public function removeAsset(id : String) : void
		{
			if ( hasAsset(id))
			{
				var asset : IAsset = _assetMap[ id ] as IAsset;
				asset.dispose();

				_assetMapByUrl[ asset.url ] = null;
			}

			_assetMap[ id ] = null;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.getAssetByUrl()
		 */
		public function getAssetByUrl(url : String) : IAsset
		{
			return _assetMapByUrl[ url ] as IAsset;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.hasAssetByUrl()
		 */
		public function hasAssetByUrl(url : String) : Boolean
		{
			return _assetMapByUrl[ url ] != null;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.removeAssetByUrl()
		 */
		public function removeAssetByUrl(url : String) : void
		{
			if ( hasAssetByUrl(url))
			{
				removeAsset(getAssetByUrl(url).id);
			}
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.getGroup()
		 */
		public function getGroup(id : String) : IGroup
		{
			return _groupMap[ id ] as IGroup;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.hasGroup()
		 */
		public function hasGroup(id : String) : Boolean
		{
			return _groupMap[ id ] != null;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.removeGroup()
		 */
		public function removeGroup(id : String) : void
		{
			if ( hasGroup(id))
			{
				var group : IGroup = _groupMap[ id ] as IGroup;
				group.dispose();
			}

			_groupMap[ id ] = null;
		}

		/**
		 * @copy org.robotlegs.utilities.assetloader.core.IAssetLoader.addAssetClass()
		 */
		public function addAssetClass(contains : String, assetClass : Class) : void
		{
			_assetClassMap[ contains ] = assetClass;
		}

		/**
		 * Instantiate a new <code>Asset</code>.
		 * 
		 * @param url The url of the <code>Asset</code>.
		 * @return The new instance of the <code>Asset</code>.
		 */
		protected function instantiateAsset(url : String) : IAsset
		{
			var id : String = ( _assetIds++ ).toString();
			var prefix : String = url.indexOf('http://') == -1 && _baseUrl ? _baseUrl : '';
			var assetClass : Class = AssetUtil.getAssetClassByExtension(url, _assetClassMap, String(url.split('.').pop()).toLowerCase());
			var asset : IAsset = new assetClass(id, prefix + url, _loaderContext) as IAsset;

			_assetMap[ id ] = asset;
			_assetMapByUrl[ url ] = asset;

			return asset;
		}

		/**
		 * Instantiate a new <code>Group</code> of <code>Assets</code>.
		 * 
		 * @param urls THe urls of the <code>Assets</code>.
		 * @return The new instance of the <code>Group</code>.
		 */
		protected function instantiateGroup(urls : Vector.<String>) : IGroup
		{
			var url : String;
			var assets : Vector.<IAsset> = new Vector.<IAsset>;

			for each ( url in urls )
			{
				assets.push(instantiateAsset(url));
			}

			var id : String = ( _assetIds++ ).toString();
			var group : IGroup = new Group(id, assets);

			_groupMap[ id ] = group;

			return group;
		}
	}
}