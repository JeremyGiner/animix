package mon_calc.ds.event;

import mon_calc.entity.Mon;
import mon_calc.ds.EEventType;

typedef SwitchOutContext = {
	var type :EEventType;
	var side :Bool;
	var mon :Mon;
};