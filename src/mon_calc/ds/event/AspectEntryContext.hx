package mon_calc.ds.event;

import mon_calc.entity.Mon;
import mon_calc.battle_aspect.IAspect;
import mon_calc.aspect.core.IAspectBearer;
import mon_calc.entity.Battle;

typedef AspectEntryContext = {
	var type :EEventType;
	var source_mon :Mon;
	var source :IAspect; // TODO : always Aspect ?
	
	var target :IAspectBearer;
	//var target_side :Bool;
	var aspect :IAspect;

	var prevent_default :Bool;
};