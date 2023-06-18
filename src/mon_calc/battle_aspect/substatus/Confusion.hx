package mon_calc.battle_aspect.substatus;

import mon_calc.ds.ThisContext;
import mon_calc.ds.enumeration.EPriorityAttack;
import mon_calc.aspect.core.AAspect;
import mon_calc.effect.Damage;
import mon_calc.entity.Move;
import mon_calc.ds.MoveContext;

class Confusion extends AAspect {

	var _iTurn :Int;

	public function new( iTurn :Int ) {
		super([OnAttack],[],[]);
		_iTurn = iTurn;
	}

	override public function getPriority() {
		return String.fromCharCode( cast EPriorityAttack.Confusion );
	}

	override public function onAttack( oContext :ThisContext, oEvent :MoveContext ) {
		
		// Fade out
		_iTurn--;
		if( _iTurn == 0 ) {
			oContext.owner.removeAspect( this );
			return;
		}

		oContext.processor.log('TOTO is confused');

		// Case : is lucky -> do nothing
		if( ! oContext.processor.getChance( 0.33 ) ) return;

		


		// TODO : Confusion damage is unaffected by Wonder Guard, 
		// Technician, and a held Life Orb
		//TODO : it cannot score a critical hit
		// TODO : more other bullshit

	
		// Attack self
		oEvent.mon_def = oEvent.mon_att;
		ATTACK.onAttack( oContext, oEvent );
		oEvent.turnover = true;
		oContext.processor.log('TOTO is hit himself');
	}


	static private var ATTACK = new Damage(40,null,Physic);

}