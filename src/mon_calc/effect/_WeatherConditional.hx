package mon_calc.effect;

import mon_calc.ds.ThisContext;
import mon_calc.battle_aspect.IAspect;
import mon_calc.ds.MoveContext;
import mon_calc.ds.EPriority;
import mon_calc.battle_aspect.weather.AWeather;

class WeatherConditional extends AConditional {
	
	var _oWeather :Class<IAspect>;
	
	public function new( 
		oWeather :Class<IAspect>,
		aChild :Array<IAspect>, 
		aChildElse :Array<IAspect>, 
		ePriority :EPriority = Normal
	) {
		super( aChild, aChildElse, ePriority );
		_oWeather = oWeather;
	}

	override public function validateCondition( oContext :ThisContext, oEvent :MoveContext ) {
		return oContext.battle.getAspectByClass( _oWeather ) != null;
	}
}