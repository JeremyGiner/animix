package animix.core.aspect;

import animix.event.DamageContext;
import animix.ds.Context;
import mon_calc.core.effect.IEffect;

interface OnDamage extends IEffect<DamageContext> {
	public function getPriority() :String;
}