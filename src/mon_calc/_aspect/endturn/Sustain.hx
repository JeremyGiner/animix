package mon_calc.aspect.endturn;

import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.Mon;

class Sustain extends AAspect {
	public function new() {
		super([OnTurnEnd],[],[]);
	}
	override public function onTurnEnd( oContext :ThisContext) {
		super.onTurnEnd( oContext );
		if( !Std.isOfType(oContext.owner,Mon) ) throw '!!!';
		var oMon :Mon = cast oContext.owner;
		oMon.healPercent( 1/16 );
	}
}
