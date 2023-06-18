package mon_calc.battle_aspect.status;

import mon_calc.ds.event.StatCalcContext;
import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.tool.IntTool;
import mon_calc.ds.MoveContext;

class ParaStatus extends AMainStatus {

	public function new() {
		super([OnAttack,OnStatCalc],[Self],[]);
	}

	override public function getPriority() {
		return String.fromCharCode( cast EPriorityAttack.MainStatus );
	}

	override function onStatCalc(oContext:ThisContext, oEvent:StatCalcContext) {
		oEvent.stat.set(
			Speed,
			IntTool.div( oEvent.stat.get(Speed), 2 )
		);
	}

	override function onAttack(oContext:ThisContext, oEvent:MoveContext) {
		if( oContext.processor.getChance( 0.25 ) ) {
			// Turnover
			oEvent.turnover = true;
			oContext.processor.log(oEvent.mon_att.getLabel() + ' is paralyzed');
		}
	}

}