package mon_calc.ds;

import mon_calc.battle_aspect.IOnAttack;
import mon_calc.entity.EHitType;
import mon_calc.entity.Battle;
import mon_calc.entity.Move;
import mon_calc.entity.Mon;

typedef EndTurnContext = {
	var battle :Battle;
}