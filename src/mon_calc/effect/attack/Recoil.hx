package mon_calc.effect.attack;

import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;

class Recoil extends AAspect {

	var _fPercent :Float;

	public function new( fPercent :Float ) {
		_fPercent = fPercent;
		super([OnDamagePost],[Dealing],[]);
	}

	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		oEvent.mon_att.damagePercent( _fPercent );
		oContext.processor.log(oEvent.mon_att.getLabel() + ' suffer recoil');
	}
}