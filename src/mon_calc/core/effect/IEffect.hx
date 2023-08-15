package mon_calc.core.effect;

import animix.ds.Context;
import animix.ds.EEventType;

interface IEffect<CSubject> {
	public function notify( oContext :Context, o :CSubject ) :Void;
}