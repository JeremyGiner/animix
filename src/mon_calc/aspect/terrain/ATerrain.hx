package mon_calc.aspect.terrain;

import mon_calc.aspect.core.IAspectBearer;
import mon_calc.core.BattleProcessor;
import mon_calc.aspect.core.AAspect;

class ATerrain extends AAspect implements IStackable {
	override public function getMainClass() {
		return ATerrain;
	}

	public function addStack( 
		oProcessor :BattleProcessor, 
		oTarget :IAspectBearer,  
		oAspect :IStackable 
	) {
		oTarget.removeAspect( this );
		oTarget.addAspect( oAspect );
	}
}