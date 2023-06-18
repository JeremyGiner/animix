package mon_calc.battle_aspect.substatus;

import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.BattleSlot;
import mon_calc.entity.Mon;
import mon_calc.entity.Battle;

class LeechSeed extends AAspect {
	// Battleslot index
	var _iBenefactor :Int;

	public function new( iSlotIndex :Int ) {
		super([OnTurnEnd],[],[Trap]);
		_iBenefactor = iSlotIndex;
	}

	override function onTurnEnd( o :ThisContext ) {
		if( !Std.isOfType( o.owner, Mon ) ) throw '!!!';
		var oMon :Mon = cast o.owner;
		var iDamage = Math.floor(oMon.getMaxHealth() / 16);

		// TODO : use index for team battle
		var oBenefactor = o.battle.getBattleSlot( ! o.side );
		
		o.processor.damage({
			type: OnDamagePre,
			target: oMon,
			damage: iDamage,
			source: this,
			mon_att: null,
			prevent_default: false,
		});
		o.processor.heal({
			type: OnHealPre,
			target: oBenefactor.getMon(),
			damage: iDamage,
			source: this,
			mon_att: null,
			prevent_default: false,
		});
	}

}