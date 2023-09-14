package animix.core.effect;

import mon_calc.ds.event.MoveCalcContext;
import mon_calc.core.effect.IEffect;
import mon_calc.ds.ThisContext;


interface OnMove extends IEffect {
	public function getPriority() :String;
	public function onMove( oContext :ThisContext, oEvent :MoveCalcContext ) :Void;
}