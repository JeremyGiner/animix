package mon_calc.entity;

import mon_calc.tool.StringTool;
import mon_calc.battle_aspect.IAspect;

class Item {
	
	var _sKey :String;
	var _sLabel :String;
	var _aAspect :Array<IAspect>;

	public function new( sKey :String, sLabel :String, aEffect :Array<IAspect> ) {
		_sKey = sKey;
		_sLabel = sLabel;
		_aAspect = aEffect;
	}

	public function getKey() { return _sKey; }
	public function getLabel() { return _sLabel; }


	public function getAspectAr() {
		return _aAspect;
	}
}