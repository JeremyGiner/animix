package animix.entity;

import mon_calc.core.entity.ABattleSlot;

class BattleSlot extends ABattleSlot<Ani> {
	public function new(side :Bool, oBattler :Ani) {
		super(side, oBattler);
	}
}