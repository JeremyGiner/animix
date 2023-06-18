package mon_calc.effect.stat;

import mon_calc.entity.EStat;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;

class SwapStat implements IEffect {
	var _a :EStat; 
	var _b :EStat;
	public function new( a :EStat, b :EStat ) {
		_a = a; _b = b;
	}
	public function getPriority() { return cast EPriority.Normal; }
	public function onAttack( oContext :MoveContext ) {
		var oTarget = oContext.stat_att; // Self

		var iStatA = oTarget.get( _a );
		var iStatB = oTarget.get( _b );

		oTarget.set( _a, iStatB);
		oTarget.set( _b, iStatA);
		oContext.battle.log(oContext.mon_att.getLabel() + ' switch his stats');
	}
}