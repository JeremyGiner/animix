package mon_calc.ds;

import mon_calc.core.IProcess;
import mon_calc.ds.ThisContext;
import mon_calc.battle_aspect.IAspect;

typedef PairAspectContext = {
	var context :ThisContext;
	var aspect :IAspect;
};