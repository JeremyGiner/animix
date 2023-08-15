package animix.aspect;

import animix.event.MoveContext;
import animix.ds.Context;
import animix.core.aspect.OnMove;
import animix.ds.EDamageType;
import animix.ds.EDamageElement;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.core.aspect.AAspect;
import animix.aspect.Damage;


class MoveDamage extends AAspect implements OnMove {

	var _oDamage :Damage;

	public function new(
		iPower :Int,
		eType :Null<EDamageElement>,
		eCategory :EDamageType,
		aFlag :Array<EAspectFlag> = null
	) {
		super([]);
		_oDamage = new Damage(iPower, eType, eCategory);
	}

	public function getPriority() {
		return '';
	}

	public function getFlagAr() { return _aFlag; }

	public function notify( oContext :Context, oEvent :MoveContext ) {
		_oDamage.process(oContext, oEvent);

	}
}
