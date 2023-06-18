package mon_calc.effect.move_transform;

import mon_calc.entity.Move;
import mon_calc.battle_aspect.status.AMainStatus;
import mon_calc.ds.ThisContext;
import mon_calc.ds.event.MoveCalcContext;
import mon_calc.aspect.core.AAspect;

class Facade extends AAspect {
	public function new() {
		super([OnMoveCalc],[],[]);
	}

	override function onMoveCalc(oContext:ThisContext, oEvent:MoveCalcContext) {
		if( !oEvent.mon.hasAspectByClass(AMainStatus) ) return;

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
					oDamage.getHitType(), oDamage.getDamageCategory(), 
					oDamage.getFlagAr()  
				);
			} ) 
		);
	}
}