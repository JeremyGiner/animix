package mon_calc.entity;

import mon_calc.battle_aspect.IAspect;

class Ability {

	var _sLabel :String;
	var _aAspect :Array<IAspect>;
	
	public function new( sLabel :String, aAspect :Array<IAspect> ) {
		_sLabel = sLabel;
		_aAspect = aAspect;
	}

	public function getAspectAr() { return _aAspect; }

}