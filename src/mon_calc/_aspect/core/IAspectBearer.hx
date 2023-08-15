package mon_calc.aspect.core;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.EventContext;
import mon_calc.ds.PairAspectContext;
import mon_calc.battle_aspect.IAspect;

interface IAspectBearer {
	//public function hasAspect( oClass :Class<IAspect> ) :Bool;
	public function getAspectOneByClass<C>( oClass :Class<C> ) :C;
	public function getAspectAr() :Array<IAspect>;
	public function hasAspect( o :IAspect ) :Bool;
	public function addAspect( o :IAspect ) :Void;
	public function removeAspect( o :IAspect ) :Bool;
	public function getAspectByEvent( oContext :ThisContext ) :Array<PairAspectContext>;
	public function hasAspectByClass( oClass :Class<Dynamic> ) :Bool;
}