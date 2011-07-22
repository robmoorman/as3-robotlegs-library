package org.robotlegs.utilities.assetloader.core
{
	/**
	 * Loading states for <code>Assets</code> and <code>Groups</code>.
	 * 
	 * @author r.moorman
	 */
	public class AssetLoaderState
	{
		/**
		 * State after the <code>Asset</code> is instantiated and is not yet started to load.
		 */
		public static const INITIALIZING: String = 'initializing';
		
		/**
		 * State after the <code>Asset</code> is successfully loaded.
		 */
		public static const LOADED: String = 'loaded';
		
		/**
		 * State while the <code>Asset</code> is loading.
		 */
		public static const LOADING: String = 'loading';
		
		/**
		 * State after being stopped manually.
		 */
		public static const STOPPED: String = 'stopped';
		
		/**
		 * State after the <code>Asset</code> failed to load (due a illegal operation or a security error).
		 */
		public static const FAILED: String = 'failed';
	}
}