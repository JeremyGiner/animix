package mon_calc.effect.aspect_applier;

import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.aspect.core.AAspect;
import mon_calc.battle_aspect.status.DeadlyPoisonStatus;
import mon_calc.battle_aspect.status.PoisonStatus;
import mon_calc.tool.MonTool;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;
import mon_calc.battle_aspect.IAspect;

class PoisonApplier extends AAspect {
	
	var _bDeadly :Bool;

	public function new( bDeadly :Bool ) {
		super([OnAttack],[Dealing],[]);
		_bDeadly = bDeadly;
	}

	override public function getPriority() {
		return String.fromCharCode( cast EPriorityAttack.AfterDamage );
	}

	override function onAttack( oContext:ThisContext, oEvent:MoveContext ) {
		var oMon = oEvent.mon_def;
		if( ! MonTool.isPoisonable( oMon ) ) {
			oContext.processor.log(oMon.getLabel() + ' cannot be poisonned.');
			return;
		}
		oContext.processor.addAspect(
			oMon, 
			_bDeadly ? new DeadlyPoisonStatus() : new PoisonStatus(), 
			oEvent.mon_att, 
			this
		);
		
	}
}