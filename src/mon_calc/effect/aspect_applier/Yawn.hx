package mon_calc.effect;


class Yawn
extends AspectApplier
{
	public function new() {
		super(
			new Drowsy(),
			[TargetSleepable],
			EPriority.posteffect
		); 
	}
	override public function onAttack( oBattle :Battle, oOwner :IAspectBearer ) {
		if( !Std.is(oOwner,Mon) ) throw '!!!';
		var oMon = cast(oOwner,Mon);
		oMon.removeAspect(IMainStatus);
	}
}