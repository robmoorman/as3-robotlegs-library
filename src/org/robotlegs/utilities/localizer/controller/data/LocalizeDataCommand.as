package org.robotlegs.utilities.localizer.controller.data
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.localizer.core.ILocalizer;
	import org.robotlegs.utilities.localizer.error.LocalizerError;
	import org.robotlegs.utilities.localizer.events.LocalizerEvent;
	import org.robotlegs.utilities.localizer.patterns.locale.ILocale;
	
	/**
	 * Localize <code>XML</code> or <code>Object</code> data.
	 * 
	 * @author r.moorman
	 */
	public class LocalizeDataCommand extends Command
	{
		[Inject]
		/**
		 * The <code>LocalizerEvent</code> that executed this <code>Command</code>.
		 */
		public var event: LocalizerEvent;
		
		[Inject]
		/**
		 * Reference to the <code>Localizer</code> utility.
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
		 * Iterate <code>Object</code> data for mappings.
		 * 
		 * @data The data to be iterated.
		 * @prefix The prefix of all iterated mappings.
		 */
		private function iterateProperties( data: Object, prefix: String ): void
		{
			var prop: String;
			
			for( prop in data ) {
				if(( typeof data[ prop ]).toString().toLowerCase() === 'object' ) {
					mapValue( prop, data[ prop ], prefix );
					
					iterateProperties( data[ prop ], prefix + prop + '.' );
				}
				else {
					mapValue( prop, data[ prop ], prefix );
				}
			}
		}
		
		/**
		 * Iterate <code>XML</code> data for mappings.
		 * 
		 * @data The data to be iterated.
		 * @prefix The prefix of all iterated mappings.
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
		 * Map a value in the <code>Injector</code> under a name.
		 * 
		 * @param value The name under which the value should be mapped.
		 * @param value The value to be mapped.
		 * @param prefix The prefix of the mapping.
		 */
		private function mapValue( name: String, value: Object, prefix: String ): void
		{
			var named: String = prefix + name;
			var injector: IInjector = event.childInjector ? event.childInjector : injector;
			
			switch(( typeof value ).toString().toLowerCase()) {
				case 'string':
					if( value.toString().toLowerCase() === 'true' || value.toString().toLowerCase() === 'false' ) {
						injector.mapValue( Boolean, value.toString().toLowerCase() === 'true', named );
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