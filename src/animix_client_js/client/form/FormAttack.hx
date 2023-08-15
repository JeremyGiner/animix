package animix_client_js.client.form;

import animix.ds.EDamageType;
import animix.aspect.MoveDamage;
import animix.ds.EDamageElement;

class FormAttack extends AViewComposite implements IForm<MoveDamage> {
    
	var _oRange :InputRange;
	var _oElement :InputSelect;
	var _oType :InputSelect;

    public function new() {
		_oRange = new InputRange('Damage', 'damage', 0, 100);
		_oElement = new InputSelect('Element', 'element', [
			'fire' => 'Fire',
			'water' => 'Water',
			'air' => 'Air',
			'earth' => 'Earth',
			'electric' => 'Electric',
		]);
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
			_resolveElement( _oElement.getValue() ),
			_resolveType( _oType.getValue() ),
			[]
		);
	}

	private function _resolveElement(s :String) :EDamageElement {
		switch(s) {
			case 'air': return Air;
			case 'water': return Water;
			case 'fire': return Fire;
			case 'earth': return Earth;
			case 'electric': return Electric;
		}
		throw 'invalid ' + s;
	}

	private function _resolveType(s :String) :EDamageType {
		switch(s) {
			case 'physique': return Physic;
			case 'magic': return Magic;
		}
		throw 'invalid ' + s;
	}
}