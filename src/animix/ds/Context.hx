package animix.ds;

import mon_calc.core.IState;
import mon_calc.core.aspect.IAspectBearer;
import mon_calc.core.aspect.IAspect;
import animix.entity.Battle;
import mon_calc.core.IProcess;

typedef Context = {
	var process :IState;
	var battle :Battle;
	var bearer :IAspectBearer;
	var aspect :IAspect;
}