package mon_calc.ds.event;

import mon_calc.ds.EEventType;
import mon_calc.action.IAction;

typedef ActionPromptContext = {
	var type :EEventType;
	var action :Array<IAction>;
	var side :Bool;
};