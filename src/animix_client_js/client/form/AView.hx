package animix_client_js.client.form;

import haxe.ds.StringMap;
import js.Browser;
import js.html.Element;

class AView implements IView {

	var _dom :Element;
	var _uid :Int;

    private function new(tag :String = 'div') {
		_dom = Browser.document.createElement(tag);
		untyped _dom.hxComponent = this;
		_uid = TplManager.uid();
		_dom.setAttribute('data-client-id', _uid+'' );
    }

	public function getId() {
		return _uid;
	}

	public function getDomElement() {
		return _dom;
	}

	public function renderTemplate(s :String) {
		var div = Browser.document.createDivElement();
		div.innerHTML = s;
		
		if( div.children.length != 1 ) throw '!!';
		return div.children[0];
	}

	public function createInput(
		label :String, 
		name :String, 
		attr :StringMap<String> = null
	) {
		var input = Browser.document.createInputElement();
		input.placeholder = label;
		input.name = name;
		if( attr.iterator().hasNext() ) {
			throw 'TODO';
		}
		return input;
	}
}