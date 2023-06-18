package mon_calc.battle_aspect;

import mon_calc.core.IProcess;
import mon_calc.ds.enumeration.EAspectFlag;
import mon_calc.ds.ThisContext;
import mon_calc.ds.EEventType;

interface IAspect {
	
	public function getLabel() :String;
	public function getPriority() :String;
	public function getEvent() :Array<EEventType>;

	public function validate( o :ThisContext ) :Bool;
	public function process( oContext :ThisContext ) :Void;
	
	
	public function hasFlag( e :EAspectFlag ) :Bool;
	public function getMainClass() :Class<IAspect>;
}