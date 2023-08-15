package mon_calc.core.aspect;

import mon_calc.ds.enumeration.EAspectFlag;

class AAspect implements IAspect {

	var _aFlag :Array<EAspectFlag>;

	public function new( 
		aFlag :Array<EAspectFlag>
	) {
		_aFlag = aFlag;
	}

	public function hasFlag( e :EAspectFlag ) { return _aFlag.contains( e ); }
}