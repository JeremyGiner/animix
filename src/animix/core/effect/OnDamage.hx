package animix.core.effect;

import mon_calc.core.effect.IEffect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.ThisContext;


interface OnDamage extends IEffect {
	public function getPriority() :String;
	public function onAttack( oContext :ThisContext, oEvent :MoveContext ) :Void;
}