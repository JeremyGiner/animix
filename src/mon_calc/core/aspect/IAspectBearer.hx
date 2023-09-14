package mon_calc.core.aspect;

import mon_calc.ds.event.EventContext;

interface IAspectBearer {
	public function getAspectByClass<C>( oClass :Class<C> ) :Array<C>;
	public function getAspectOneByClass<C>( oClass :Class<C> ) :C;
	public function getAspectAr() :Array<IAspect>;
	public function hasAspect( o :IAspect ) :Bool;
	public function addAspect( o :IAspect ) :Void;
	public function removeAspect( o :IAspect ) :Bool;
	public function hasAspectByClass( oClass :Class<Dynamic> ) :Bool;
}