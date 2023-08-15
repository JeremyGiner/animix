package animix_client_js;

import js.Browser;
import animix_client_js.client.form.FormMoveCreation;
import animix_client_js.client.Client;
import animix.entity.Team;

/**
 * ...
 * @author 
 */
 class Main {

	static var _oInstance :Main;

	var _oTeamRed :Team;
	var _oTeamBlue :Team;
	var _oClient :Client;
	
//_____________________________________________________________________________
// Boot

	static public function main() {
		_oInstance = new Main();
	}
	
//_____________________________________________________________________________
// Constructor

	public function new() {
		_oClient = new Client();
		var oForm = new FormMoveCreation();

		_oClient.renderDyna(
			oForm
		);

		// _oTeamRed = new Team('RED',[
		// 	new Ani(
		// 		'Salamender',
		// 		new AniType(),
		// 		[Mag=>250], 0, Nature.get( 1 ), 
		// 		[
		// 			new Move(
		// 				'MOVE1', 'Flame blast',
		// 				Fire

		// 			),
		// 			_mMove.get('SWORDS_DANCE'),
		// 			_mMove.get('EARTHQUAKE'),
		// 			_mMove.get('OUTRAGE'),
		// 		],
		// 		null
		// 	)
		// ]);


		// TODO : move maker
		// TODO : ani maker
		// TODO : team maker


		// combat();
		// trace('END');
		//genMon();
		


		

		// new Battle();

		// var oBattle = new Battle(
		// 	new Team('Red',[
		// 		new Mon(
		// 			mMonType.get('VENUSAUR'),[],null,null,Nature(Att,Mag),[
		// 				mMove.get('ABSORB'),
		// 				mMove.get('GROWTH'),
		// 				mMove.get('PETAL_BLIZZARD'),
		// 				mMove.get('PETAL_DANCE'),
		// 			]
		// 		),
		// 	]),
		// 	new Team('Blue',[
		// 		new Mon(
		// 			mMonType.get('VENUSAUR'),[],null,null,Nature(Mag,Att),[
		// 				mMove.get('ABSORB'),
		// 				mMove.get('GROWTH'),
		// 				mMove.get('PETAL_BLIZZARD'),
		// 				mMove.get('PETAL_DANCE'),
		// 			]
		// 		),
		// 	]),
		// 	function processInput( oBattle :Battle, fChance :Float ) {
		// 		return Math.random() > fChance;
		// 	}
		// );
	}

//_____________________________________________________________________________
// Accessor

	public function getClient() {
		return _oClient;
	}
	
//_____________________________________________________________________________
// Singleton
	
	static public function get() { return _oInstance; }
}
