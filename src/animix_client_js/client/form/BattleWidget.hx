package animix_client_js.client.form;

import mon_calc.core.IState;
import animix.state.BattleBeginState;
import animix.state.AniActionState;
import animix.entity.Battle;

class BattleWidget extends AView {
	
	var _oState :IState;
	var _oActionChoice :ActionChoiceWidget;
	
	public function new( oBattle :Battle ) {
		_oState = new BattleBeginState(oBattle);
		
		super();
		_dom.innerHTML = '<div>
		<div class="row">
			<div class="col">
				<img />
			</div>
			<div class="col">
				<img />
			</div>
		</div>
		<div class="row">
			<div data-actionbox></div>
		</div>
		</div>';

		_process();
	}

	private function _process() {

		var actionbox = _dom.querySelector('[data-actionbox]');
		
		//Reset
		_oActionChoice = null;
		actionbox.remove();


		while(! Std.isOfType(_oState, AniActionState) ) {
			_oState = _oState.process();
		}

		_oActionChoice = new ActionChoiceWidget(cast _oState, _chooseAction);
		actionbox.append(_oActionChoice._dom);

		
	}

	private function _chooseAction(i :Int) {

		if(! Std.isOfType(_oState, AniActionState) ) 
			throw '!!';

		var oActionState :AniActionState = cast _oState;


		oActionState.setRedAction( i );
		oActionState.setBlueAction( 
			Math.floor(
				Math.random() * oActionState.getBlueActionAr().length
			)
		);
	}
}