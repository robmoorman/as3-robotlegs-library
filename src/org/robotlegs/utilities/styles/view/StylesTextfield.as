package org.robotlegs.utilities.styles.view
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.robotlegs.utilities.styles.core.IStyles;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class StylesTextfield extends TextField
	{
		/**
		 * @inheritDoc
		 */
		override public function set text( value: String ): void {
			htmlText = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set htmlText( value: String ): void {
			if( styleSheet ) {
				super.htmlText = _styleName != null ? '<span class="' + _styleName + '">' + value + '</span>' : value;
			}
			else {
				_text = value;
			}
		}
		
		[Inject]
		/**
		 * 
		 */
		public var styles: IStyles;
		
		/**
		 * @private
		 */
		private var _styleName: String;
		
		/**
		 * @private
		 */
		private var _text: String;
		
		/**
		 * Constructor.
		 * 
		 * @param styleName
		 * @param autoSize
		 */
		public function StylesTextfield( styleName: String = null, autoSize: String = TextFieldAutoSize.LEFT )
		{
			super();
			
			_styleName = styleName;
			
			this.autoSize = autoSize;
		}
		
		[PostConstruct]
		/**
		 * 
		 */
		public function onPostConstruct(): void
		{
			styleSheet = styles.styleSheet;
			
			if( _text ) {
				htmlText = _text;
			}
		}
	}
}