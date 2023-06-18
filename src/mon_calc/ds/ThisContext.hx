package mon_calc.ds;

import mon_calc.entity.Mon;
import mon_calc.core.BattleProcessor;
import mon_calc.aspect.core.IAspectBearer;
import mon_calc.ds.event.EventContext;
import mon_calc.entity.Battle;

typedef ThisContext = {
	var processor :BattleProcessor;
	var battle :Battle;
	var side :Null<Bool>;
	var mon :Mon;

	var owner :IAspectBearer;

	var event :EventContext;
};