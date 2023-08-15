package mon_calc.aspect;


class Download 
implements IOnSwitchIn
{
	public function onSwitchIn( oContext :SwitchInContext ) {
	
		var oBattle = oContext.battle;
	
		// TODO : use sum for team battle
		// Get opposite team
		var oFoe = oContext.battle.getCurrentMon( oContext.side );
		var mFoeStat = oBattle.getCurrentStat( oFoe );
		
		if( mFoeStat.get(Def) <= mFoeStat.get(Res) )
			oBattle.changeStatModifier( oContext.mon, Att, 1, this );
		else 
			oBattle.changeStatModifier( oContext.mon, Mag, 1, this );
	}
}