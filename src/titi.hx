class ContactAspectApplier implements IOnContact {

	var _a :Array<IAspect>;

	public function new( a :Array<IAspect> ) {
		_a = a;
	}
	public function getPriority() :String { return cast EPriority.Normal; }
	public function onContact( oContext :MonDamageContext ) {
		for( o in _a ) {
		
			// TODO : check aspect prevention (eg poison on steel)
			oContext.mon_att.addAspect( o /* TODO : copy ?*/ );
		}
	}
}

class Pressure implements IOnMoveSuccessful {
	// TODO : lower PP -1
}

class SwitchInEffect implements IOnSwitchIn {

	var _a :Array<IEffect>;
	
	public function new( a :Array<IEffect> ) {
		_a = a;
	}

	public function getPriority() :String { return cast EPriority.Normal; }
	public function onSwichIn( oBattle :Battle, oMon :Mon ) {
		for( oEffect in _a ) {
			oEffect.onAttack({ // TODO : turn effect into IProcedure ?
				battle: oBattle,
				mon_att: oBattle,
			})
		}
	}
	
}

class PreventCrit implements IOnPreAspectEnty {
	public function getPriority() :String { 
		return cast EPriority.Recalc; // After calc but before execution
	}
	public function onAttack( oContext :MoveContext ) {
		oContext.crit_chance = 0;
	}
}

class PreventAspect implements IOnPreAspectEnty {

	// TODO :been able to prevent to prevention (cf Ability Corrosion)

	var _a :Array<IAspect>;

	public function new( a :Array<IAspect> ) {
		_a = a;
	}

	public function getPriority() :String { return cast EPriority.Normal; }
	public function onPreAspectEntry( 
		oBattle :Battle, 
		oMon :Mon, 
		oAspect :IAspect 
	) :Bool {
		for( oClass in _a ) {
			if( Std.is(oAspect,oClass) ) return false;
		}
		return true;
	}
}



____________________________________________________________________________________


class StealthRock extends ATrap {

	override public function onSwichIn( oBattle :Battle, oMon :Mon ) { 
		oMon.damagePercent( 1/16 );
		oBattle.log('TOTO got damaged by rock');
	}
}

class StickyWeb extends ATrap {

	override public function onSwichIn( oBattle :Battle, oMon :Mon ) { 
		var oMod = oMon.getAspect( StatModifier );
		if( oMod == null ) {
			oMod = new StatModifier();
			oMon.addAspect( oMod );
		}
		oMod.addModifier( Speed, -1 );
		oBattle.log('TOTO got slowed by web');
	}
}




class IgnoreStatChange implements IEffect {

	public function getPriority() :String { return cast EPriority.Precalc; }
	public function onAttack( oContext :MoveContext ) {
	
		// TODO : recal stats
	}
}














____________________________________________________________________________________

/**
 * Brickbreak for protect
 */
class EffectIgnore 
implements IEffect
implements IOnAttack {
	
	var _oClass :Class<IEffect>;
	
	public function new( oClass :Class<IEffect> ) {
		_oClass = oClass;
	}
	
	public function getPriority() { return '0' };
	
	public function onAttack( oContext :MoveContext ) {
		oContext.stack.filter(function( o ) {
			return ! Std.is( o, _oClass );
		});
	}
}

____________________________________________________________________________________



____________________________________________________________________________________

class Charging 
implements IAspect
implements IOnAttack {
	
	var _iTurn :Int;
	var _oChild :IOnAttack;
	
	public function new( oChild :IOnAttack ) {
		_iTurn = 2;
		_oChild = oChild;
	}
	
	public function getPriority() { return '5'; }
	

	// Block player action
	public function onActionChoice() {
		return [new Action()]; // TODO : use action without PP, create special move ?
	}

	public function onAttack( oContext :MoveContext ) {
		_iTurn--;
		if( _iTurn != 0 ) return;
		_oChild.onAttack( oContext );
	}
}

____________________________________________________________________________________

class Shield extends AFading implements ITeamAspect {

	var _eCat :ECategory;

	public function new( eCat :ECategory, iTurn :Int ) {
		_eCat = eCat;
		super( iTurn );
	}

	public function onAttack( oContext :MoveContext ) {
	
		if( oContext.move.getCategory() == _eCat ) return;
	
		oContext.factor *= 0.5;
	}
}

____________________________________________________________________________________

// TODO : Damage -> skip if type affinity 0
____________________________________________________________________________________

class RemoveItem implements IOnAttack {


	public function getPriority() {
		return cast EPriority.Normal; // TODO : before damage ? before item def ?
	}
	
	
	public function onAttack( oContext :MoveContext ) {
	
		var oItem = oContext.mon_def.getItem();
		oContext.mon_def.setItem( null );
	
		// Remove item
		oContext.battle.log('TOTO lose '+oItem.getLabel());
	}
}

____________________________________________________________________________________

class SuckerPunch {
	
	var _oChild :IOnAttack;
	
	public function new( oChild :IOnAttack ) {
		_oChild = oChild;
	}
	
	public funtion getMovePriority( oMon :Mon, oMove :Move ) {
		return BeforeAll;
	}
	
	// TODO : trigger on damage or on damaging move ?
	
	public function onAttack( oContext :MoveContext ) {
	
		if(  )
	
		// Apply damage
		oChild.onAttack( oContext );
	}
}

____________________________________________________________________________________
____________________________________________________________________________________


____________________________________________________________________________________

static public function build( 
	sId :String,
	sLabel :String,
	eType :EHitType,
	eCategory :EHitCategory,
	iPower :Null<Int>,
	fAccuracy :Null<Float>,
) {
	var aEffect = new Array<IOnAttack>();
	if( iPower != null )
		aEffect.push( new Damage( iPower, eType ) );
	if( fAccuracy != null )
		aEffect = [new AccuracyCheck(fAccuracy, aEffect) ];
	return new Move( sId, sLabel, aEffect );
}

____________________________________________________________________________________

class Chance extends AConditional {
	
	var _fChance :Float;
	
	public function new( 
		fChance :Float,
		aChild :Array<IOnAttack>, 
		aChildElse :Array<IOnAttack>, 
		ePriority :EPriority 
	) {
		super( aChild, aChildElse, ePriority );
		_fChance = fChance;
	}

	override public function validate( oContext :MoveContext ) {
		return oContext.battle.getChange( fChance );
	}
}

____________________________________________________________________________________

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
			getPower() * (oType == Normal ? 1 : 2),
			getAccuracy(),
			[]
		);
	}
}

____________________________________________________________________________________


/**
 * For Wish & Prediction
 */
class Delayed 
implements IAspect
implements IOnTurnBegin {

	var _iTurn :Int;
	var _oSource :Mon;
	var _oEffect :IOnAttack;

	public function new( var iTurn :Int, oSource :Mon, oEffect :IOnAttack ) {
		_iTurn = iTurn;
		_oSource = oSource;
		_oEffect = oEffect;
	}
	
	public function onTurnBegin() { // TODO is it on turn end?
		_iTurn--;
		
		if( _iTurn != 0 ) return;
		
		_oEffect.onAttack( TODO ); // Create context ? execute on att ?
		
	}
}

____________________________________________________________________________________

class AConditional 
implements IAspect
implements IOnAttack {
	
	var _aChild :Array<IOnAttack>;
	var _aChildElse :Array<IOnAttack>;
	var _ePriority :EPriority;
	
	public function new( 
		aChild :Array<IOnAttack>, 
		aChildElse :Array<IOnAttack>,
		ePriority :EPriority 
	) {
		_aChild = aChild;
		_aChildElse = aChildElse;
		_ePriority = ePriority;
	}
	
	public function getPriority() :String { return cast _ePriority; }
	
	public function onAttack( oContext :MoveContext ) {
		var a = validate( oContext ) ? 
			_aChild : _aChildElse;
		;
		for( o in a )
			o.onAttack( oContext );
	}
	
	public function validate( oContext :MoveContext ) {
		throw 'override me';
	}
}

____________________________________________________________________________________


____________________________________________________________________________________

class RegenPercent 
implements IAspect
implements IOnAttack
{
	
	var _fPercent :Float;
	var _ePriority :EPriority;
	
	public function new( fPercent :Float, ePriority :EPriority ) {
		_fPercent = fPercent;
		_ePriority = ePriority;
	}
	
	public function getPriority() :String { return cast _ePriority; }
	
	public function onAttack( oContext :MoveContext ) {
		// TOOD : handle multiple target ?
		var oMon = oContext.mon_att;
		oMon.healPercent( _fPercent );
	}
}
