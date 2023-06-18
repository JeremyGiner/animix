package mon_calc.effect;

import mon_calc.battle_aspect.IOnAttack;

class RegenPercent implements IEffect {
	
	var _fPercent :Float;
	var _ePriority :EPriority;
	
	public function new( fPercent :Float, ePriority :EPriority ) {
		_fPercent = fPercent;
		_ePriority = ePriority;
	}
	
	public function getPriority() :String { return cast _ePriority; }
	
	public function onAttack( oContext :MoveContext ) {
		// TOOD : handle multiple target ?
		var oMon = oContext.mon_att;
		oMon.healPercent( _fPercent );
	}
}