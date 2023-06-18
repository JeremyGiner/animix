package mon_calc.effect.move_transform;

import mon_calc.battle_aspect.weather.SandStorm;
import mon_calc.battle_aspect.weather.Hail;
import mon_calc.battle_aspect.weather.Sunny;
import mon_calc.entity.EHitType;
import mon_calc.battle_aspect.weather.Rain;
import mon_calc.battle_aspect.weather.AWeather;
import mon_calc.entity.Move;
import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.MoveCalcContext;
import mon_calc.aspect.core.AAspect;

class WheaterBall extends AAspect {
	public function new() {
		super([OnMoveCalc],[],[]);
	}

	override function onMoveCalc(oContext:ThisContext, oEvent:MoveCalcContext) {

		var oWeather = oContext.battle.getAspectByClass(AWeather);
		if( oWeather == null ) return;

		var oWeatherClass = Type.getClass( oWeather );

		// Double the damage power
		var oMoveBase = oEvent.move;
		oEvent.move = new Move(
			oMoveBase.getId(),oMoveBase.getLabel(),
			oMoveBase.getHitType(), null, oMoveBase.getTarget(),
			oMoveBase.getAspectAr().map(function( oAspect ) {
				if( !Std.isOfType(oAspect,Damage) ) return oAspect;

				var oDamage = cast(oAspect,Damage);
				return new Damage( 
					oDamage.getPower() * 2, 
					_getHitType( oWeatherClass ), oDamage.getDamageCategory(), 
					oDamage.getFlagAr()  
				);
			} ) 
		);
	}

	private function _getHitType( oClass :Class<AWeather> ) :EHitType {
		switch( oClass ) {
			case Rain: return Water;
			case Sunny: return Fire;
			case Hail: return Ice;
			case SandStorm: return Rock;
		}
		return Normal;
	}
}