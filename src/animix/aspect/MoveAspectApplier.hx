package animix.aspect;

import mon_calc.core.aspect.IAspect;
import sweet.functor.builder.IFactory;
import animix.event.MoveContext;
import animix.ds.Context;
import animix.core.aspect.OnMove;
import mon_calc.core.aspect.AAspect;


class MoveAspectApplier extends AAspect implements OnMove {

	var _oAspectFactory :IFactory<IAspect>;

	public function new(
		oAspectFactory :IFactory<IAspect>
	) {
		_oAspectFactory = oAspectFactory;
		super([]);
	}

	public function getPriority() {
		return '';
	}

	public function getFlagAr() { return _aFlag; }

	public function notify( oContext :Context, oEvent :MoveContext ) {
		oContext.process.addAspect(
			oEvent.defender,
			_oAspectFactory.create()
		);
	}
}
