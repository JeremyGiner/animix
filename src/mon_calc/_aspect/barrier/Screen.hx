package mon_calc.aspect.barrier;

import mon_calc.ds.event.DamageCalcContext;
import mon_calc.ds.ThisContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.EDamageCategory;


class Screen extends AAspect {

	var _oCategory :EDamageCategory;

	public function new( oCategory :EDamageCategory ) {
		super([OnDamageCalc],[
			AllyReceiving,
			_oCategory == Physic ? DamagePhy : DamageMag,
		],[Barrier,Screen],5);
	}
	public function setTurn( i :Int ) {
		_iFade = i;
	}
	override public function onDamageCalc( oContext :ThisContext, oContext :DamageCalcContext ) {
		// TODO : is there other damage source with category ?
		//if( !Std.isOfType( oContext.source, Damage ) ) return;

		oContext.factor *= 0.5;
	}
}