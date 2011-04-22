package org.robotlegs.utilities.localizer.controller.install
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.localizer.core.ILocalizer;
	import org.robotlegs.utilities.localizer.core.Localizer;
	import org.robotlegs.utilities.localizer.events.LocalizerEvent;
	import org.robotlegs.utilities.localizer.controller.data.LocalizeDataCommand;
	
	/**
	 * Map dependencies of <code>Localizer</code>.
	 * 
	 * <p>The following depedencies are available after executing this <code>Command</code>:</p>
	 * 
	 * <ul>
	 * 	<li><code>ILocalizer</code></li>
	 * </ul>
	 * 
	 * @author r.moorman
	 */
	public class InstallLocalizerCommand extends Command
	{
		/**
		 * @inheritDoc
		 */
		override public function execute(): void
		{
			injector.mapSingletonOf( ILocalizer, Localizer );
			
			commandMap.mapEvent( LocalizerEvent.LOCALIZE_DATA, LocalizeDataCommand, LocalizerEvent );
		}
	}
}