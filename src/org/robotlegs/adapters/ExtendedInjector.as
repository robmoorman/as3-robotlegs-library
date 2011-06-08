package org.robotlegs.adapters
{
	import flash.system.ApplicationDomain;
	
	import org.robotlegs.core.IInjector;

	/**
	 * 
	 * 
	 * @author r.moorman
	 */
	public class ExtendedInjector extends SwiftSuspendersInjector
	{
		/**
		 * @inheritDoc
		 */
		public function ExtendedInjector( xmlConfig: XML = null )
		{
			super( xmlConfig );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createChild( applicationDomain: ApplicationDomain = null ): IInjector
		{
			var injector: ExtendedInjector = new ExtendedInjector();
			injector.setApplicationDomain( applicationDomain );
			injector.setParentInjector( this );
			
			return injector;
		}
	}
}