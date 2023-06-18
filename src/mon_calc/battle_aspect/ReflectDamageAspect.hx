package mon_calc.battle_aspect;

class ReflectDamageAspect {
	var _fPercent :Float;

	public function new( fPercent :Float ) {
		_fPercent = fPercent;
	}
	public function onMonAttPost( oBattle :Battle, oMonAtt :Mon, oMove :Move, iDamage :Int, oMonDef :Mon ) {
	
		// TODO : filter depending on damage category
		oMonAtt.damage( Math.floor( iDamage * getPercent() ) );
	}
	public function getPercent() { return _fPercent; }
}
