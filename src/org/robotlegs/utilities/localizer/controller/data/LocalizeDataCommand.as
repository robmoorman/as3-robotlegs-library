package org.robotlegs.utilities.localizer.controller.data
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.localizer.core.ILocalizer;
	import org.robotlegs.utilities.localizer.error.LocalizerError;
	import org.robotlegs.utilities.localizer.events.LocalizerEvent;
	import org.robotlegs.utilities.localizer.patterns.locale.ILocale;
	
	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class LocalizeDataCommand extends Command
	{
		[Inject]
		/**
		 * 
		 */
		public var event: LocalizerEvent;
		
		[Inject]
		/**
		 * 
		 */
		public var localizer: ILocalizer;
		
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			var data: Object;
			var prefix: String;
			var locale: ILocale = event.locale;
			
			if( locale ) {
				data = locale.data;
				prefix = '';
			}
			else if( event.data ) {
				data = event.data;
				prefix = event.prefix.length ? event.prefix + '.' : '';
			}
			else {
				throw new LocalizerError( 'LocalizerEvent does not have data provided!' );
			}
			
			if( data is XML ) {
				iterateChilds( data as XML, prefix );
			}
			else if( data is Object ) {
				iterateProperties( data, prefix );
			}
		}
		
		/**
		 * 
		 * 
		 * @data
		 * @prefix
		 */
		private function iterateProperties( data: Object, prefix: String ): void
		{
			var prop: String;
			
			for( prop in data ) {
				if( localizer.iterateObjectsInCustomData && ( typeof data[ prop ]).toString().toLowerCase() === 'object' ) {
					mapValue( prop, data[ prop ], prefix );
					
					iterateProperties( data[ prop ], prefix + prop + '.' );
				}
				else {
					mapValue( prop, data[ prop ], prefix );
				}
			}
		}
		
		/**
		 * 
		 * 
		 * @data
		 * @prefix
		 */
		private function iterateChilds( data: XML, prefix: String ): void
		{
			var child: XML;
			
			for each( child in data.children()) {
				if( child.hasSimpleContent()) {
					mapValue( child.name().toString(), child.toString(), prefix );
				}
				else {
					mapValue( child.name().toString(), child, prefix );
					
					iterateChilds( child, prefix + child.name().toString() + '.' );
				}
			}
		}
		
		/**
		 * 
		 * 
		 * @param value The name under which the value should be mapped.
		 * @param value The value to map.
		 * @param prefix
		 */
		private function mapValue( name: String, value: Object, prefix: String ): void
		{
			var named: String = prefix + name;
			
			switch(( typeof value ).toString().toLowerCase()) {
				case 'string':
					if( value.toString().toLowerCase() === 'true' || value.toString().toLowerCase() === 'false' ) {
						injector.mapValue( Boolean, value.toString().toUpperCase() === 'true', named );
					}
					else {
						injector.mapValue( String, value.toString(), named );
					}
					break;
				default:
					injector.mapValue( getDefinitionByName( getQualifiedClassName( value )) as Class, value, named );
					break;
			}
		}
	}
}