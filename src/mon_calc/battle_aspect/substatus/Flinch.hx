package mon_calc.battle_aspect.substatus;

import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.ds.MoveContext;

class Flinch extends AAspect {
	
	public function new() {
		super([OnAttack],[Dealing],[],0);
	}

	override public function getPriority() {
		return String.fromCharCode( cast EPriorityAttack.Flinch );
	}

	override function onAttack( oContext:ThisContext, oEvent:MoveContext ) {
		// Turnover
		oEvent.turnover = true;
		oContext.processor.log('TOTO flinched');
	}
}