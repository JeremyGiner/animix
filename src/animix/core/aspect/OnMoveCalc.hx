package animix.core.aspect;

import animix.event.MoveCalcContext;
import animix.ds.Context;
import mon_calc.core.effect.IEffect;


interface OnMoveCalc extends IEffect<MoveCalcContext> {
	public function getPriority() :String;
}