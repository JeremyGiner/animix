package animix.core.aspect;

import animix.event.DamageCalcContext;
import animix.ds.Context;
import mon_calc.core.effect.IEffect;

interface OnDamageCalc extends IEffect<DamageCalcContext> {
	public function getPriority() :String;
}