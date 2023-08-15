package animix.core.effect;

import mon_calc.core.effect.IEffect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.ThisContext;


interface OnSwitchOut extends IEffect<MoveContext> {
	public function getPriority() :String;
}