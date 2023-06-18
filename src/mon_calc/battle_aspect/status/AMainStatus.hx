package mon_calc.battle_aspect.status;

import mon_calc.aspect.core.AAspect;

class AMainStatus extends AAspect {

    override public function getMainClass() :Class<IAspect> {
        return AMainStatus;
    }
}