package mon_calc.ds;

typedef ItemRemoveContext = {
	var battle :Battle;
	var target_side :Bool;
	
	var emmiter :IAspectBearer;
	var source :IAspect; // TODO : always Aspect ?
	
	var target :IAspectBearer;
	var item :Item;
};