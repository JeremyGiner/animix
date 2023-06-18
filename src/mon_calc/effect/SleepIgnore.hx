package mon_calc.effect;

import mon_calc.entity.Battle;
import mon_calc.tool.IntTool;
import mon_calc.entity.Mon;
import mon_calc.entity.Move;
import mon_calc.action.PlayerAction;
import mon_calc.event.AttackEvent;
import mon_calc.system.BattleProcess;
import mon_calc.ability.Adaptability;
import mon_calc.ds.MoveContext;
import mon_calc.ability.IBaseDamageModifier;


class SleepIgnore implements IMoveEffect {

	public function process( oContext :MoveContext ) :Bool {

		oContext.blacklist.push( SleepStatus );

		return true;
	}

	
	
}
