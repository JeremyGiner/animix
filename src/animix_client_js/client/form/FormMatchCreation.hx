package animix_client_js.client.form;

import animix.entity.Battle;

class FormMatchCreation extends AView implements IForm<Battle> {

	var oInputTeamRed :FormTeamCreation;
	var oInputTeamBlue :FormTeamCreation;


    public function new() {
        super('form');
		_dom.addEventListener('submit',submit);
		var layout = new Layout([
			oInputTeamRed = new FormTeamCreation('Red'),
            oInputTeamBlue = new FormTeamCreation('Blue'),
            oInputTeamBlue = new FormTeamCreation('Blue'),
		]);
		_dom.append(layout._dom);
		_dom.append(new Submit('Battle !', '')._dom);
    }

	public function submit() {
		if( ! validate() ) return;
		var oBattle = getValue();

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