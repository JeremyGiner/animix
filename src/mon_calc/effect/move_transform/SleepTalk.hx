package mon_calc.effect.move_transform;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.MoveCalcContext;
import mon_calc.aspect.core.AAspect;

class SleepTalk extends AAspect {
	
	public function new() {
		super([OnMoveCalc],[],[]);
	}

	override function onMoveCalc(
		oContext :ThisContext, 
		oEvent :MoveCalcContext
	) {
		var aMove = oEvent.mon.getMoveAr().filter(function( oMove ) {
			return oMove != oEvent.move; // Filter self
		});
		// TODO : filter moves
		throw 'not implemented yet';
		if( aMove.length == 0 ) 
			oEvent.move = null;
		else
			oEvent.move = oContext.processor.getChanceAr( aMove );
	}
}