package animix_client_js.client.form;

import js.html.Event;
import animix.entity.Battle;

class FormMatchCreation extends AView implements IForm<Battle> {

	var oInputTeamRed :FormTeamCreation;
	var oInputTeamBlue :FormTeamCreation;
	var _fnSubmit :FormMatchCreation->Void;


    public function new(fnSubmit :FormMatchCreation->Void = null) {
        super('form');
		_fnSubmit = fnSubmit;
		_dom.addEventListener('submit',submit);
		var layout = new Layout([
			oInputTeamRed = new FormTeamCreation('Red'),
            oInputTeamBlue = new FormTeamCreation('Blue'),
		]);
		_dom.append(layout._dom);
		_dom.append(new Submit('Battle !', '')._dom);
    }

	public function submit( oEvent :Event ) {
		oEvent.preventDefault();
		if( ! validate() ) throw '!!!';
		_fnSubmit(this);
	}

	public function validate() {
		var a = [
			oInputTeamRed.validate(),
			oInputTeamBlue.validate(),
		];
		return ! a.contains(false);
	}

	public function getValue() {
		return new Battle(
			oInputTeamRed.getValue(),
			oInputTeamBlue.getValue()
		);
	}

    
}