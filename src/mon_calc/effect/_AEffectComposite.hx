package mon_calc.effect;

import mon_calc.ds.EPriority;
import mon_calc.ds.MoveContext;

class AEffectComposite implements IEffect {

	var _aChild :Array<IEffect>;

	public function new( aChild :Array<IEffect> ) {
		_aChild = aChild;
	}
	public function getPriority() :String { return cast EPriority.Normal; }

	public function getChildAr() { return _aChild; }
	public function getChildByClass( oClass :Class<IEffect> ) { 

		for( oChild in getChildAr() ) {
			if( Std.is( oChild, oClass ) )
				return oChild;
			if( Std.is( oChild, AEffectComposite ) ) {
				var o = cast(oChild,AEffectComposite)
					.getChildByClass( oClass );
				if( o != null ) return o;
			}
		}
		return null; 
	}

	public function onAttack( oContext :MoveContext ) {
		for( o in getChildAr() )
			o.onAttack( oContext );
	}



}