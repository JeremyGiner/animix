package mon_calc.aspect.core;

import mon_calc.ds.ThisContext;


interface IAspect2 {
	public function getEvent() :Array<EEvent>;
	public function validate( o :Event ) :Bool;
	public function process( 
		oThisContext :ThisContext, 
		oEventContext :Event 
	) :Void;
	public function hasFlag( e :EAspectFlag ) :Bool;
}
