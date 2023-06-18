package mon_calc.ds.event;

import mon_calc.entity.Mon;
import mon_calc.entity.EStat;

typedef StatCalcContext = {
	var type :EEventType;
    var side :Bool;
    var mon :Mon;
    var stat :Map<EStat,Int>;
};