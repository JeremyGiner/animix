package mon_calc.aspect;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.entity.EHitType;
import mon_calc.ds.EPriority;
import mon_calc.ds.MonDamageContext;
import mon_calc.effect.Damage;
import mon_calc.entity.Mon;
import mon_calc.aspect.core.AAspect;


class InPinchBoost extends AAspect {
	var _oType :EHitType;
	public function new( oType :EHitType ) {
		super([OnDamageCalc],[Self],[]);
		_oType = oType;
	}

	override function onDamageCalc(oContext:ThisContext, oEvent:DamageCalcContext) {
		if( !_isPinch( oEvent.att_mon ) ) return;
		
		var oDamage = oEvent.damage;
		if( oDamage.getHitType() != _oType ) return;
		
		oEvent.factor *= 1.5;
		oContext.processor.log('Boost!');
	}
	
	private function _isPinch( oMon :Mon ) {
		return oMon.getHealth() < oMon.getMaxHealth()/3;
	}
}