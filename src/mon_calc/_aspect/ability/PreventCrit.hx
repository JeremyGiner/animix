package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;

class PreventCrit extends AAspect {

    public function new() {
        super([OnDamageCalc],[Receiving],[]);
    }

    override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
        oEvent.crit_chance = null;
    }
}