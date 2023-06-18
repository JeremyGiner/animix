package mon_calc.aspect.core;

import mon_calc.core.IProcess;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.PairAspectContext;
import mon_calc.ds.ThisContext;

class AAspectBearer implements IAspectBearer {

	var _aAspect :Array<IAspect>;

	private function new(  
		aAspect :Array<IAspect> = null
	) {
		_aAspect = aAspect == null ? [] : aAspect;
	}

//_____________________________________________________________________________
// Accessor

	public function getAspectByClass<C>( oClass :Class<C> ) :C {
		for( o in getAspectAr() )
			if( Std.isOfType(o,oClass) ) return cast o;
		return null;
	}

	public function hasAspect( o :IAspect ) { return _aAspect.contains( o ); }
	public function getAspectAr() { return _aAspect; }

	public function hasAspectByClass( oClass :Class<Dynamic> ) {
		return getAspectByClass( oClass ) != null;
	}

	public function getAspectByEvent( oContext :ThisContext ) :Array<PairAspectContext> {
		return getAspectAr().filter( function( oAspect :IAspect ) {
				return oAspect.getEvent().contains( oContext.event.type );
			})
			.map(function( oAspect :IAspect ) {
				return {
					context: oContext,
					aspect: oAspect,
				};
			})
			.filter(function( oPair :PairAspectContext ) {
				return oPair.aspect.validate( oPair.context );
			});
	}

//_____________________________________________________________________________
// Modifier

	public function addAspect( o :IAspect ) {
		_aAspect.push( o );
	}

	public function removeAspect( oAspect :IAspect ) {
		return _aAspect.remove( oAspect );
	}
}
