package org.robotlegs.utilities.styles.core
{
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	import org.robotlegs.utilities.assetloader.core.IAssetLoader;
	import org.robotlegs.utilities.assetloader.events.AssetLoaderEvent;
	import org.robotlegs.utilities.assetloader.patterns.asset.type.CSSAsset;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class Styles extends Actor implements IStyles
	{
		/**
		 * @copy org.robotlegs.utilities.styles.core.IStyles.styleSheet
		 */
		public static function getStyleSheet(): StyleSheet {
			return _styleSheet;
		}
		
		/**
		 * @copy org.robotlegs.utilities.styles.core.IStyles.styleSheet
		 */		
		public function get styleSheet(): StyleSheet {
			return _styleSheet;
		}
		
		[Inject]
		/**
		 * 
		 */
		public var assetLoader: IAssetLoader;
		
		/**
		 * @private
		 */
		private static var _styleSheet: StyleSheet;
		
		/**
		 * @private
		 */
		private var _styleMap: Dictionary;
		
		/**
		 * @private
		 */
		private var _closure: Function;
		
		/**
		 * Constructor.
		 */
		public function Styles()
		{
			super();
			
			_styleMap = new Dictionary;
			_styleSheet = new StyleSheet;
		}
		
		/**
		 * @copy org.robotlegs.utilities.styles.core.IStyles.addStyle()
		 */
		public function addStyle( styleSheet: StyleSheet ): void
		{
			var styleName: String;
			
			for each( styleName in styleSheet.styleNames ) {
				_styleSheet.setStyle( styleName, styleSheet.getStyle( styleName ));
			}
		}
		
		/**
		 * @copy org.robotlegs.utilities.styles.core.IStyles.loadStyle()
		 */
		public function loadStyle( url: String, closure: Function = null ): void
		{
			_closure = closure;
			
			assetLoader.load( url, onStyleProgress );
		}
		
		/**
		 * 
		 * 
		 * @param evt
		 */
		private function onStyleProgress( evt: AssetLoaderEvent ): void
		{
			switch( evt.type ) {
				case AssetLoaderEvent.ASSET_COMPLETE:
					if( evt.asset is CSSAsset ) {
						addStyle(( evt.asset as CSSAsset ).styleSheet );
					}
					
					if( _closure != null ) {
						_closure.apply( null, null );
						_closure = null;
					}
					break;
			}
		}
	}
}