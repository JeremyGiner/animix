package animix.event;

import animix.entity.Ani;
import mon_calc.core.effect.IEffect;

typedef DamageContext = {
	var source :Ani;
	var target :Ani;
	var source_effect :Dynamic;
	var damage :Int;
	var prevent_default :Bool;
}