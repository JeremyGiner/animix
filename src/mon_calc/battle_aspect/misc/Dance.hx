package mon_calc.battle_aspect.misc;

import mon_calc.ds.ThisContext;
import mon_calc.ds.event.ActionPromptContext;
import mon_calc.aspect.core.AAspect;
import mon_calc.action.MonForcedAction;
import mon_calc.battle_aspect.substatus.Confusion;
import mon_calc.ds.MonDamageContext;
import mon_calc.entity.Battle;
import mon_calc.entity.Mon;
import mon_calc.ds.EPriority;
import mon_calc.entity.Move;
import mon_calc.action.IAction;


class Dance extends AAspect {

	var _iMove :Int;
	var _iTurn :Int;
	var _bDisrupted :Bool;

	public function new( 
		iTurn :Int, iMove :Int
	) {
		super([OnActionPrompt,OnDamagePost,OnTurnStart,OnTurnEnd],[Self],[],iTurn);
		_iTurn = iTurn;
		_bDisrupted = false;
		_iMove = iMove;
	}

	override function onTurnStart(o:ThisContext) {
		_bDisrupted = true;
	}
	
	override function onActionPrompt(oContext:ThisContext, oEvent:ActionPromptContext) {
		oEvent.action = [new MonForcedAction( oEvent.side, oContext.mon.getMove( _iMove ).copyEcho() )]; 
		// TODO : what happen when encore 
	}

	override function onDamagePost(oContext:ThisContext, oEvent:MonDamageContext) {
		_bDisrupted = false;
	}

	override function onTurnEnd( o :ThisContext ) {
		super.onTurnEnd(o);
		
		if( getFadeCount() <= 0 ) {
			// Apply confusion
			o.processor.addAspect( 
				o.owner, 
				new Confusion( o.processor.getChanceAr([1,2,3]) ),
				o.mon,
				this
			);
		}
		
		if( _bDisrupted ) {
			o.owner.removeAspect( this );
		}
	}
	
}