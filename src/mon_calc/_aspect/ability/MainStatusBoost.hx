package mon_calc.aspect.ability;

import mon_calc.ds.AspectExecuteContext;
import mon_calc.ds.event.AspectEntryContext;
import mon_calc.ds.EPriority;
import mon_calc.battle_aspect.status.BurnStatus;
import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;


class MainStatusBoost extends AAspect {
	public function new() {
		super([OnDamageCalc,OnAspectExecutePre],[Self],[]);
	}

	override public function getPriority() :String { return cast EPriority.Precalc;/*Before BurnStatus*/ }

	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( ! oContext.owner.hasAspectByClass(AMainStatus) ) return;
		oEvent.factor *= 1.5;

		// TODO
		// oContext.battle.filterProcessByClass( BurnStatus, OnDamageCalc );
	}

	override function onAspectExecutePre(oContext:ThisContext, oEvent:AspectExecuteContext) {
		if( !Std.isOfType( oEvent.aspect, BurnStatus ) ) return;
		if( oEvent.event.type != OnDamageCalc ) return;

		oEvent.prevent_default = true;
	}
}