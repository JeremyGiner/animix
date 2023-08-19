package animix_client_js.client.form;

import js.Browser;
import haxe.ds.StringMap;
import animix.ds.EDamageElement;

class InputSelectElement extends AViewComposite implements IForm<EDamageElement> {

	var _element :InputSelect;

    public function new(label :String, name :String) {
		_element = new InputSelect(label, name, [
			'fire' => 'Fire',
			'water' => 'Water',
			'air' => 'Air',
			'earth' => 'Earth',
			'electric' => 'Electric',
		]);
		super([_element]);
		
    }

	public function getValue() {
		return _resolveElement( _element.getValue() );
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

}