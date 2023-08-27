package animix_client_js.client.form;

import js.html.ButtonElement;
import haxe.ds.StringMap;

class Submit extends AView implements IForm<String> {

	
    var _label :String;
    var _name :String;

    public function new(
		label :String,
		name :String,
		attr :StringMap<String> = null
	) {
        _label = label;
        _name = name;
        super('button');
		_dom.setAttribute('type', 'submit');
		_dom.setAttribute('name', name);
		_dom.classList.add('btn-primary');
		_dom.classList.add('btn');
		_dom.textContent = label;
		if (attr != null)
			for(k => v in attr) {
				_dom.setAttribute(k, v);
			}
    }
	
	public function validate() {
		return true;
	}

    public function getInputElement() :ButtonElement {
		return cast _dom;
	}

	public function getValue() :String {
		return getInputElement().value;
	}
    
	
}