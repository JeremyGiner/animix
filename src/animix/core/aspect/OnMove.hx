package animix.core.aspect;

import animix.event.MoveContext;
import mon_calc.core.effect.IEffect;

interface OnMove extends IEffect<MoveContext> {
	public function getPriority() :String;
}