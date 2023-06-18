package mon_calc.effect.attack;

import mon_calc.aspect.terrain.GrassyTerrain;
import mon_calc.tool.MonTool;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.aspect.core.AAspect;

class Earthquake extends AAspect {

    public function new() {
        super([OnDamageCalc],[],[]);
    }

    override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
        
        if( MonTool.isUnderground( oEvent.def_mon ) )
            oEvent.factor *= 2;

        if( oContext.battle.hasAspectByClass(GrassyTerrain) ) {
            oEvent.factor /= 2;
        }
    }
}