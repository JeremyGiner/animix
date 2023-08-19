package animix_client_js.client.form;

import animix.ds.ETargetType;
import animix.entity.Move;
import animix_client_js.client.form.Input;


class FormMoveCreation extends AViewComposite implements IForm<Move> {

	var _oLabel :Input;
	var _oElement :InputSelectElement;
	var _oAspect :InputAspectList;

    public function new() {
        super([
			new Input('Move label', 'label'),
			new InputSelectElement('Move element', 'element'),
            new InputAspectList('Effect'),
        ]);
    }

    public function getValue() {
		return new Move(
			'__',
			_oLabel.getValue(),
			_oElement.getValue(),
			ETargetType.SingleFoe,
			_oAspect.getValue(),
			Normal,
			null
		);
	}
}