package mon_calc.ds;

import mon_calc.battle_aspect.IAspect;
import mon_calc.core.IProcess;
import mon_calc.ds.event.EventContext;
import mon_calc.ds.EEventType;
import mon_calc.aspect.core.IAspectBearer;

typedef AspectExecuteContext = {
	var type :EEventType;
	var owner_side :Bool;
	
	var owner :IAspectBearer;
	var aspect :IAspect;
	var event :EventContext;
	var prevent_default :Bool;
};