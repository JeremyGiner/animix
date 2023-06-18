package mon_calc.effect.aspect_applier;

import mon_calc.battle_aspect.substatus.Confusion;
import mon_calc.battle_aspect.status.DeadlyPoisonStatus;
import mon_calc.battle_aspect.status.PoisonStatus;
import mon_calc.tool.MonTool;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;
import mon_calc.battle_aspect.IAspect;

class ConfusionApplier implements IEffect {
	
	public function new() {}

	public function getPriority() { return cast EPriority.Postcalc; }

	public function onAttack( oContext :MoveContext ) {
		var oMon = oContext.mon_def;
		oMon.addAspect( new Confusion( oContext.battle.getChanceAr([1,2,3,4])) );
		oContext.battle.log(oMon.getLabel() + ' is confused.');
	}
}