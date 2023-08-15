package animix.core.effect;

import animix.event.SwitchContext;
import mon_calc.core.effect.IEffect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.ThisContext;


interface OnSwitchIn extends IEffect<SwitchContext> {
	public function getPriority() :String;
}