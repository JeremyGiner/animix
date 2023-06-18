package mon_calc.ds;

import mon_calc.ds.EEventType;
import mon_calc.battle_aspect.IAspect;
import mon_calc.entity.EStat;
import mon_calc.entity.Battle;
import mon_calc.entity.Move;
import mon_calc.entity.Mon;

typedef MoveContext = {
	var type :EEventType;
	var side_att :Bool;

	var mon_att :Mon;
	var stat_att :Map<EStat,Int>;

	var mon_def :Mon;
	var stat_def :Map<EStat,Int>;

	var move :Move;

	var turnover :Bool;
}