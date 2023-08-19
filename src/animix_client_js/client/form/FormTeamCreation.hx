package animix_client_js.client.form;

import animix.entity.Team;
import js.html.InputElement;
import animix_client_js.client.form.Input;
import animix.entity.Ani;

class FormTeamCreation extends AViewComposite implements IForm<Team> {

	var _oLabel :Input;
	var _oAni0 :FormAniCreation;
	var _oAni1 :FormAniCreation;
	var _oAni2 :FormAniCreation;

    public function new(defaultLabel :String) {
        super([
			_oLabel = new Input('Name', 'label', ['value' => defaultLabel]),
			_oAni0 = new FormAniCreation(),
            _oAni1 = new FormAniCreation(),
            _oAni2 = new FormAniCreation(),
        ]);
    }

    public function getValue() {
		return new Team(
			_oLabel.getValue(),
			[
				_oAni0.getValue(),
				_oAni1.getValue(),
				_oAni2.getValue(),
			]
		);
	}
}