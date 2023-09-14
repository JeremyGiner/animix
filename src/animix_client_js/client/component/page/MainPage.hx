package animix_client_js.client.component.page;

import animix_client_js.client.form.BattleWidget;
import animix_client_js.client.form.FormMatchCreation;
import animix_client_js.client.form.AViewComposite;

class MainPage extends AViewComposite {
	
	var _oFormMatchCreation :FormMatchCreation;
	var _oBattleWidget :BattleWidget;

	public function new() {
		_oFormMatchCreation = new FormMatchCreation(this.submitMatchCreation);
		_oBattleWidget = null;
		super([
			_oFormMatchCreation,
		]);
	}

	private function submitMatchCreation(oForm :FormMatchCreation) {
		_oBattleWidget = new BattleWidget( 
			_oFormMatchCreation.getValue() 
		);
		this._dom.append(_oBattleWidget._dom);
	}
}