package mon_calc.aspect;


class Drowsy
extends AAspect2
{
	public function new() {
		super([],[],1); // after hydration
	}
	override public function onFade( oBattle :Battle, oOwner :IAspectBearer ) {
		if( !Std.is(oOwner,Mon) ) throw '!!!';
		var oMon = cast(oOwner,Mon);
		if( ! MonTool.isSleepable( oBattle, oMon ) ) return;
		oBattle.addAspect( 
			oMon, 
			new SleepStatus( oBattle.getChanceAr([1,2,3]) ),
			this 
		);
	}
}