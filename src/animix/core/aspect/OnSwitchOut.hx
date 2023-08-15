package animix.core.aspect;

import animix.event.SwitchContext;
import animix.ds.Context;
import mon_calc.core.effect.IEffect;

interface OnSwitchOut extends IEffect<SwitchContext> {
	public function getPriority() :String;
	public function notify( oContext :Context, oEvent :CSubject ) :Void;
}