package animix_client_js.client.form;

import animix.ds.EDamageType;
import animix.aspect.MoveDamage;
import animix.ds.EDamageElement;

class FormAttack extends AViewComposite implements IForm<MoveDamage> {
    
	var _oRange :InputRange;
	var _oElement :InputSelectElement;
	var _oType :InputSelect;

    public function new() {
		_oRange = new InputRange('Damage', 'damage', 0, 100);
		_oElement = new InputSelectElement('Element', 'element');
		_oType = new InputSelect('Element', 'element', [
			'physique' => 'Physique',
			'magic' => 'Magic',
		]);
        super([
            _oRange,
			_oElement,
			_oType,
        ]);
    }

	public function getValue() {
		return new MoveDamage(
			_oRange.getValueInt(),
			_oElement.getValue(),
			_resolveType( _oType.getValue() ),
			[]
		);
	}

	

	private function _resolveType(s :String) :EDamageType {
		switch(s) {
			case 'physique': return Physic;
			case 'magic': return Magic;
		}
		throw 'invalid ' + s;
	}
}