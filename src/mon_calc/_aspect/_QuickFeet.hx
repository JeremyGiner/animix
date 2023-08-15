package mon_calc.aspect;


class QuickFeet
extends AAspect2
{
	public function new() {
		super([OnStatCalc,OnAspectExecutePre],[TargetOwner,TargetHasStatus]);
	}
	override public function onStatCalc( 
		oBattle :Battle, 
		oOwner :IAspectBearer, 
		m :Map<EStat,Int> 
	) {
		m.set(Speed,Math.floor( m.get(Speed) * 1.5 ) );
		return m;
	}
	
	override public function onAspectExecutePre( 
		oContext :AspectExecuteContext
	) {
		if( Std.is( oContext, Paralyze ) ) {
			oContext.prevent_default = true;
		}
	}
}