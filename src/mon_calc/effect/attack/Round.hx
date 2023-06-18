package mon_calc.effect.attack;

import mon_calc.aspect.core.AAspect;

class Round extends AAspect {
    
    public function new() {
        super([OnDamageCalc],[],[]);
    }

    // TODO : change move priority consecutive Round need to be used right after the first
    // TODO : double power if Round has been used before
}