package mon_calc.entity;

// import mon_calc.core.process.MonActionProcess;
import haxe.Serializer;
import haxe.Unserializer;
import mon_calc.aspect.core.AAspectBearer;

class Battle extends AAspectBearer {

	var _oTeamRed :Team;
	var _oTeamBlue :Team;

	var _aBattleSlotRed :Array<BattleSlot>;
	var _aBattleSlotBlue :Array<BattleSlot>;

//_____________________________________________________________________________
// Constructor

	public function new(  
		oTeamRed :Team, oTeamBlue :Team
	) {
		super();
		_oTeamRed = oTeamRed;
		_oTeamBlue = oTeamBlue;

		_aBattleSlotRed = [new BattleSlot( false, _oTeamRed.getMon(0) )];
		_aBattleSlotBlue = [new BattleSlot( true, _oTeamBlue.getMon(0) )];
	}

	public function copy() {
		var o = new Battle( _oTeamRed.copy(), _oTeamBlue.copy() );
		o._aBattleSlotRed = _aBattleSlotRed.map(( oSlot :BattleSlot ) -> {
			var i = _oTeamRed.getMonIndex( oSlot.getMon() );
			if( i == null ) throw '!!!';
			return new BattleSlot( false, o._oTeamRed.getMon( i ) );
		});
		o._aBattleSlotBlue = _aBattleSlotBlue.map(( oSlot :BattleSlot ) -> {
			var i = _oTeamBlue.getMonIndex( oSlot.getMon() );
			if( i == null ) throw '!!!';
			return new BattleSlot( true, o._oTeamBlue.getMon( i ) );
		});
		o._aAspect = Unserializer.run( Serializer.run( _aAspect ) );
		
		return o;
	}

//_____________________________________________________________________________
// Accessor

	public function getTeamRed() { return _oTeamRed; }
	public function getTeamBlue() { return _oTeamBlue; }
	public function getTeam( bSide :Bool ) { 
		return bSide ? _oTeamBlue : _oTeamRed; 
	}
	public function getCurrentMon( bSide :Bool ) { 
		return getBattleSlot( bSide ).getMon(); 
	}

	public function getBattleSlot( bSide :Bool ) { 
		return bSide ? _aBattleSlotBlue[0] : _aBattleSlotRed[0]; 
	}

	public function isDone() {
		if( 
			_oTeamRed.hasValidMon() 
			|| _oTeamBlue.hasValidMon() 
		) return false;
		return true;
	}
}