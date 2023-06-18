package mon_calc.ability;

import mon_calc.ds.EPriority;
import mon_calc.effect.AEffectComposite;
import mon_calc.effect.Damage;
import mon_calc.effect.IEffect;
import mon_calc.battle_aspect.IOnAttack;
import mon_calc.entity.EHitType;
import mon_calc.ds.MoveContext;

class InPinch extends AAbility implements IOnAttack {

	var _e :EHitType;

	public function new( eHitType :EHitType ) {
		_e = eHitType;
		super();
	}

	public function getPriority() :String { return cast EPriority.Normal; }

	public function getHitType() { return _e; }

	public function onAttack( oContext :MoveContext ) {

		var oDamage :Damage = null;
		for( oAspect in oContext.aspect_stack ) {
			if( Std.is(oAspect,Damage) ){
				oDamage = cast oAspect;
				break;
			}
			if( Std.is(oAspect,AEffectComposite) ){

				oDamage = cast cast( oAspect, AEffectComposite)
					.getChildByClass(Damage);
				if( oDamage != null ) break;
			}
		}
		
		if( oDamage.getHitType() != _e ) return;
		if( !oContext.mon_att.isInPinch() ) return;

		oContext.factor *= 1.5;
	}
}