package mon_calc.entity;

import mon_calc.ds.ETargetType;
import mon_calc.aspect.core.AAspectBearer;
import mon_calc.aspect.core.AAspect;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.EMovePriority;
import mon_calc.tool.IValidator;

class Move extends AAspectBearer {
	
	var _sId :String;
	var _sLabel :String;

	var _eTarget :ETargetType;
	var _iPointMax :Null<Int>;
	var _eHitType :Null<EHitType>;
	var _ePrioity :EMovePriority;

	var _oRequirement :IValidator<Dynamic>;

	public function new( 
		sId :String, sLabel :String,

		eHitType :Null<EHitType>,
		iPointMax :Null<Int>,

		eTarget :ETargetType,
		aAspect :Array<IAspect> = null,

		ePrioity :EMovePriority = Normal,
		oRequirement :IValidator<Dynamic> = null
	) {
		super( aAspect );
		_sId = sId; _sLabel = sLabel;

		_eHitType = eHitType;
		_iPointMax = iPointMax;

		_eTarget = eTarget;
		
		_ePrioity = ePrioity;
		_oRequirement = oRequirement;
	}

	public function copyEcho() { return new Move(
		_sId, _sLabel, _eHitType, null/*NO PP*/, _eTarget, getAspectAr(), _ePrioity, null
	); }

	public function getId() { return _sId; }
	public function getLabel() { return _sLabel; }
	public function getHitType() { return _eHitType; }
	public function getPointMax() { return _iPointMax; }
	public function getValidator() { return _oRequirement; }
	public function getPriority() :Int { return cast _ePrioity; }
	public function getTarget() { return _eTarget; }

	

}