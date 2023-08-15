package mon_calc.aspect.core;

import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.ds.EPriority;
import mon_calc.ds.ThisContext;
import mon_calc.battle_aspect.IAspect;

class AAspect implements IAspect {

	public function new() {
	}

	public function getLabel() { return Type.getClassName( Type.getClass( this ) ); }
	public function getEvent() { return []; }
	public function getFadeCount() { return 0; }
	public function hasFlag( e :EAspectFlag ) { return []; }
	public function getPriority() :String { return cast EPriority.Normal; }

}