package animix_client_js.client.form;

import js.html.InputElement;
import haxe.ds.StringMap;


class AInput extends AView implements IForm<String> {
    
    var _label :String;
    var _name :String;

    public function new(
		label :String,
		name :String,
		attr :StringMap<String> = null,
		tag :String = 'input'
	) {
        _label = label;
        _name = name;
        super(tag);
		_dom.setAttribute('type', 'text');
		_dom.setAttribute('name', name);
		_dom.setAttribute('placeholder', label);
		if (attr != null)
			for(k => v in attr) {
				_dom.setAttribute(k, v);
			}
    }

    public function getInputElement() :InputElement {
		return cast _dom;
	}

	public function getValue() :String {
		return getInputElement().value;
	}
}
