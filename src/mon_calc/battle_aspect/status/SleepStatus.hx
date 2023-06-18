package mon_calc.battle_aspect.status;

import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.ds.MoveContext;

class SleepStatus extends AMainStatus {

	public function new( iTurn :Int ) {
		super([OnAttack],[Dealing],[],iTurn); 
	}

	override public function getPriority() {
		return String.fromCharCode( cast EPriorityAttack.MainStatus );
	}

	override function onAttack(oContext:ThisContext, oEvent:MoveContext) {
		// Turnover
		oEvent.turnover = true;
		oContext.processor.log('TOTO is asleep');
	}

}