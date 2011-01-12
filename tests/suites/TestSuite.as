package suites
{
	import cases.org.robotlegs.mvcs.ASyncCommandTest;
	import cases.org.robotlegs.mvcs.ASyncMacroCommandTest;
	import cases.org.robotlegs.mvcs.MacroCommandTest;
	
	[Suite]
	[RunWith( 'org.flexunit.runners.Suite' )]
	public class TestSuite
	{
		public var aSyncCommandTest: ASyncCommandTest;
		public var aSyncMacroCommandTest: ASyncMacroCommandTest;
		public var macroCommandTest: MacroCommandTest;
	}
}