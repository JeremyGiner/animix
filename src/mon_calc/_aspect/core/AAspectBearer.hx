package mon_calc.aspect.core;

import haxe.ds.StringMap;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.PairAspectContext;
import mon_calc.ds.ThisContext;

class AAspectBearer implements IAspectBearer {

	var _aAspect :Array<IAspect>;

	var _mCacheByClass :StringMap<Array<IAspect>>;

	private function new(  
		aAspect :Array<IAspect> = null
	) {
		_aAspect = aAspect == null ? [] : aAspect;
		_mCacheByClass = new StringMap<Array<IAspect>>();
	}

//_____________________________________________________________________________
// Accessor

	public function getAspectOneByClass<C>( oClass :Class<C> ) :C {
		for( o in getAspectAr() )
			if( Std.isOfType(o,oClass) ) return cast o;
		return null;
	}

	public function getAspectByClass<C:IAspect>( oClass :Class<C> ) :Array<C> {
		var s = Type.getClassName(oClass);
		if( !_mCacheByClass.exists(s) ) {
			_mCacheByClass.set( s, _aAspect.filter((oAspect :IAspect) -> {
				return Std.isOfType(oAspect, oClass);
			}));
		}
		return cast _mCacheByClass.get(s);
	}

	public function hasAspect( o :IAspect ) { return _aAspect.contains( o ); }
	public function getAspectAr() { return _aAspect; }

	public function hasAspectByClass( oClass :Class<Dynamic> ) {
		return getAspectOneByClass( oClass ) != null;
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
		_mCacheByClass.clear();
	}

	public function removeAspect( oAspect :IAspect ) {
		_mCacheByClass.clear();
		return _aAspect.remove( oAspect );
	}
}
