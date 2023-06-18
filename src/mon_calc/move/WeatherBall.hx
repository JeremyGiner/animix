package mon_calc.move;

import mon_calc.entity.Move;


class WeatherBall extends Move {
	
	public function getEffectiveMove( oBattle :Battle ) {
		
		var oWeather = oBattle.getAspect( IWeather );
		var oType :EHitType = Normal;
		switch( oWeather ) {
			case Std.is(_,Hail): oType = Ice;
			case Std.is(_,SandStorm): oType = Rock;
			case Std.is(_,HashSun): oType = Fire;
			case Std.is(_,Rain): oType = Water;
		}
		
		return new Move( 
			'WEATHER_BALL_MOD',
			'weather ball',
			oType,
			getPower() * (oWeather == null ? 1 : 2),
			getAccuracy(),
			[]
		);
	}
}