package mon_calc.aspect.ability;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;

class ToughClaws extends AAspect {
    
    public function new() {
        super([OnDamageCalc],[Dealing],[]);
    }

    override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
        if( ! oEvent.damage.hasFlag(Contact) ) return;

        oEvent.factor *= 1.3;
    }
}