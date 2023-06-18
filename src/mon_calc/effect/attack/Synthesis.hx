package mon_calc.effect.attack;

import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.battle_aspect.weather.AWeather;
import mon_calc.battle_aspect.weather.Sunny;
import mon_calc.entity.Battle;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;

class Synthesis extends AAspect {
	public function new() {
		super([OnAttack],[Dealing],[]);
	}

	override function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		var oMon = oEvent.mon_att;
		oContext.processor.heal({
			type: OnHealPre,
			attack_context: oEvent,
			mon_att: oEvent.mon_att,
			target: oMon,
			source: this,
			damage: Math.floor( oMon.getMaxHealth() *  _getPercent( oContext.battle ) ),
			prevent_default: false,
		});
	}

	private function _getPercent( oBattle :Battle ) {
		var oWeather = oBattle.getAspectByClass(AWeather);
		if( oWeather == null ) return 1/2;
		if( Std.isOfType( oWeather, Sunny ) ) return 2/3;
		return 1/4;
		// TODO : during strong winds, it restores ½ total HP
	}
}