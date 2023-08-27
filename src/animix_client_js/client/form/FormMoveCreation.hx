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
			_oLabel = new Input('Move label', 'label'),
			_oElement = new InputSelectElement('Move element', 'element'),
            _oAspect = new InputAspectList('Effect'),
        ]);
    }
	public function validate() {
		var a :Array<IForm<Dynamic>> = [
			_oLabel,
			_oElement,
			_oAspect,
		];
		return ! a.map((child) -> {
			return child.validate();
		}).contains(false);
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