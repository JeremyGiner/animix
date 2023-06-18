package mon_calc.ds.event;

import mon_calc.entity.Mon;
import mon_calc.ds.EEventType;
import mon_calc.entity.EHitType;

typedef AffinityContext = {
	var type :EEventType;

	var target :Mon;

	var att_type :EHitType;
	var def_type_ar :Array<EHitType>;
	
	var factor :Float;
};