package animix_client_js.client.form;

import js.html.InputElement;
import js.Browser;
import haxe.ds.StringMap;
import haxe.Resource;
import animix_client_js.Template;

class InputSelect extends AInput {
    
    var _choiceMap :StringMap<String>;
    var _currentValue :String;

    public function new(label :String, name :String, choiceAr :StringMap<String>) {
        _choiceMap = choiceAr;
        super(label, name, null, 'select');

		for(k => v in choiceAr) {
			_dom.append(createOption(v, k));
		}
    }

	public function createOption( label :String, value :String ) {
		var o = Browser.document.createOptionElement();
		o.setAttribute('value', value);
		o.innerText = label;
		return o;
	}

	// public function getValue() :String {
	// 	var input :InputElement = cast Browser.document.querySelector('[data-dyn-tpl="'+_uid+'"] select');
	// 	return input.value;
	// }

}