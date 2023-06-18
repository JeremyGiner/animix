package mon_calc.effect;

import mon_calc.entity.Mon;
import mon_calc.entity.Move;
import mon_calc.entity.Battle;

class AddStatModifer {

	var _mStatStage :IntMap<Int>;

	public function new( mStatStage :IntMap<Int> ) {
		_mStatStage = mStatStage;
	}

	public function process( 
		oBattle :Battle,
		oMove :Move, 
		oMonAtt :Mon, 
		oTarget :Mon = null
	) {
		if( oTarget == null ) throw '!!!';

		// TODO : get previous Aspect for this stat for this side
		
	}
}