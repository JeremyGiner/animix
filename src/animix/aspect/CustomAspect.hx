package mon_calc.effect;

import mon_calc.ds.event.SwitchOutContext;
import animix.core.effect.OnSwitchOut;
import animix.core.effect.OnSwitchIn;
import animix.core.effect.OnDamage;
import animix.ds.EDamageType;
import mon_calc.entity.EDamageCategory;
import animix.ds.EDamageElement;
import mon_calc.ds.event.DamageCalcContext;
import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.core.AAspect;
import mon_calc.ds.EPriority;
import mon_calc.tool.IntTool;
import mon_calc.entity.Mon;
import mon_calc.ds.MoveContext;


class CustomAspect 
	extends AAspect 
	implements OnDamage
	implements OnSwitchOut 
	implements OnSwitchIn 
{

	var _aDamage :Array<OnDamage>;
	var _aSwitchIn :Array<OnSwitchIn>;
	var _aSwitchOut :Array<OnSwitchOut>;

	public function new(
		aDamage :Array<OnDamage>,
		aSwitchIn :Array<OnSwitchIn>,
		aSwitchOut :Array<OnSwitchOut>
	) {
		_aDamage = aDamage;
		_aSwitchIn = aSwitchIn;
		_aSwitchOut = aSwitchOut;
	}

//_____________________________________________________________________________
// Accessor

	public function getHitType() { return _eType; }
	public function getCategory() { return _eCategory; }
	public function getDamageCategory() { return _eCategory; }
	public function getPower() { return _iPower; }
	public function getFlagAr() { return _aFlag; }

//_____________________________________________________________________________
// Process

	public function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		for( oDamage in _aDamage ) {
			oDamage.onAttack( oContext, oEvent );
		}
	}

	public function onSwitchIn( oContext :ThisContext, oEvent :SwitchInContext ) {
		for( o in _aSwitchIn ) {
			o.onSwitchIn( oContext, oEvent );
		}
	}
	public function onSwitchOut( oContext :ThisContext, oEvent :SwitchOutContext ) {
		for( o in _aSwitchOut ) {
			o.onSwitchOut( oContext, oEvent );
		}
	}

//_____________________________________________________________________________
// 
}
