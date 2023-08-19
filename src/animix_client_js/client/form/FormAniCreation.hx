package animix_client_js.client.form;

import animix.entity.AniType;
import animix.entity.Ani;
import animix.ds.EStat;

class FormAniCreation extends AViewComposite implements IForm<Ani> {

	var _oLabel :Input;
	var _oElement0 :InputSelectElement;
	var _oElement1 :InputSelectElement;
	var _oAvatar :InputAniAvatar;
	var _oMove0 :FormMoveCreation;
	var _oMove1 :FormMoveCreation;
	var _oMove2 :FormMoveCreation;
	var _oMove3 :FormMoveCreation;

    public function new() {
        super([
            _oLabel = new Input('Name','label'),
            _oElement0 = new InputSelectElement('Primary element','element0'),
            _oElement1 = new InputSelectElement('Secondary element','element1'),
            _oAvatar = new InputAniAvatar(),
            _oMove0 = new FormMoveCreation(),
            _oMove1 = new FormMoveCreation(),
            _oMove2 = new FormMoveCreation(),
            _oMove3 = new FormMoveCreation(),
        ]);
    }

	public function getValue() {
		return new Ani(
			_oLabel.getValue(),
			new AniType(
				0,
				_oLabel.getValue(),
				[
					EStat.Health => 10,
					EStat.Percing => 10,
					EStat.Defence => 10,
					EStat.Magic => 10,
					EStat.Resist => 10,
				],
				_oElement0.getValue(),
				_oElement1.getValue(),
				[],
				[],
				[]
			),
			0,
			[
				_oMove0.getValue(),
				_oMove1.getValue(),
				_oMove2.getValue(),
				_oMove3.getValue(),
			]
		);
	}

    
}