package animix.core.aspect;

import animix.ds.Context;
import animix.event.SwitchContext;
import mon_calc.core.effect.IEffect;

interface OnSwitchIn extends IEffect<SwitchContext> {
	public function getPriority() :String;
}