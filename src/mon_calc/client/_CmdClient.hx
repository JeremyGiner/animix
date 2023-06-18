package mon_calc.client;

import mon_calc.core.BattleProcessor;
import mon_calc.action.MonSwitch;
import mon_calc.action.IAction;
import mon_calc.entity.Battle;

class CmdClient {

	var _oBattle :Battle;
	
	public function new( oBattle :Battle ) {
		_oBattle = oBattle;
	}
	public function process() {
		
		var fnAction = (aAction :Array<IAction>) -> {
			var oTeam = _oBattle.getTeam( aAction[0].getSide() );

			Sys.println('Action '+oTeam.getLabel()+ ' :');
			for( i in 0...aAction.length )
				Sys.println(_getActionLabel( i, aAction[i] ));

			var s = Sys.stdin().readLine();
			var i = Std.parseInt( s );
			if( i < 0 || i >= aAction.length ) throw '!!';
			return i;
		};

		
		var oProcessor = new BattleProcessor( 
			_oBattle,
			(processor, f) -> {
				Sys.println('Rand '+(f * 100)+'% (y/n):');

				var s = Sys.stdin().readLine();
				if( s != 'y' && s != 'n' ) throw '!!';
				return s == 'y';
			},
			fnAction,fnAction
		);
		oProcessor.process();
		var bVictor = oProcessor.getVictor();
		if( bVictor == null ) throw '!!!';
		Sys.println('WIN '+ (bVictor ? 'BLUE' : 'RED'));

	}

	private function _getActionLabel( iIndex :Int, oAction :IAction ) {
		if( Std.isOfType( oAction, MonSwitch ) ) {
			return iIndex + ' - Switch to ' + untyped oAction.getMonIndex();
		}

		return iIndex + ' - ' 
			+ untyped oAction.getMove( _oBattle ).getLabel();
	}
}