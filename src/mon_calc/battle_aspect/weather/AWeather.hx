package mon_calc.battle_aspect.weather;

import mon_calc.aspect.core.IAspectBearer;
import mon_calc.core.BattleProcessor;
import mon_calc.aspect.IStackable;
import mon_calc.aspect.core.AAspect;
import mon_calc.entity.Battle;

class AWeather extends AAspect implements IStackable {
	override public function getMainClass() { return AWeather; }

	public function addStack( 
		oProcessor :BattleProcessor, 
		oTarget :IAspectBearer,  
		oAspect :IStackable 
	) {
		oTarget.removeAspect( this );
		oTarget.addAspect( oAspect );
	}
}