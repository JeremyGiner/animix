package animix.entity;

import mon_calc.core.aspect.IAspect;
import mon_calc.core.aspect.AAspectBearer;
import mon_calc.ds.ETargetType;
import mon_calc.tool.IValidator;
import mon_calc.core.effect.IEffect;
import animix.ds.EMovePriority;
import animix.ds.EDamageElement;

class Move extends AAspectBearer {
	
	var _sId :String;
	var _sLabel :String;
	var _iCost :Null<Int>;
	var _eElement :Null<EDamageElement>;
	var _ePrioity :EMovePriority;
	var _eTarget :ETargetType;

	var _oRequirement :IValidator<Dynamic>;

	public function new( 
		sId :String, sLabel :String,

		eElement :Null<EDamageElement>,

		eTarget :ETargetType,
		aEffect :Array<IAspect>,

		ePrioity :EMovePriority = Normal,
		oRequirement :IValidator<Dynamic> = null
	) {
		super( aEffect );
		_sId = sId; _sLabel = sLabel;

		_eElement = eElement;

		_eTarget = eTarget;
		
		_ePrioity = ePrioity;
		_oRequirement = oRequirement;
	}

	public function copyEcho() { return new Move(
		_sId, _sLabel, _eElement, _eTarget, getAspectAr(), _ePrioity, null
	); }

	public function getId() { return _sId; }
	public function getLabel() { return _sLabel; }
	public function getHitType() { return _eElement; }
	public function getValidator() { return _oRequirement; }
	public function getPriority() :Int { return cast _ePrioity; }
	public function getTarget() { return _eTarget; }

}