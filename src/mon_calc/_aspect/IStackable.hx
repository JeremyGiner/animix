package mon_calc.aspect;

import mon_calc.battle_aspect.IAspect;
import mon_calc.aspect.core.IAspectBearer;
import mon_calc.core.BattleProcessor;

interface IStackable extends IAspect {
	public function addStack( 
		oProcessor :BattleProcessor, 
		oTarget :IAspectBearer,  
		oAspect :IStackable 
	) :Void;
}