package animix_client_js.client.form;

import animix.aspect.MoveDamage;
import haxe.Resource;
import animix_client_js.Template;
import js.html.Element;
import mon_calc.core.aspect.IAspect;
import mon_calc.core.effect.IEffect;
import haxe.ds.StringMap;
import js.html.SelectElement;

typedef EventItem = {
	label :String,
	event_id :String,
	action_list: Array<{
		label: String,
		action_id: String,
	}>,
};

class InputAspectList extends AView implements IForm<Array<IAspect>> {

	var _label :String;
	var _aChild :Array<IForm<IAspect>>;
	
	public function new(label :String) {
		super();
		_label = label;
		_aChild = [];

		_dom.innerHTML = render();
	}

	public function validate() {
		if (_aChild.length != 0) {
			var error_box = _dom.querySelector('[data-form-error='+_uid+']');
			error_box.textContent = 'Require at least one effect.';
			return false;
		}
		return true;
	}

	public function getValue() :Array<IAspect> {
		return _aChild.map((child) -> {
			return child.getValue();
		});
	}

	public function getActionOptionMap() :StringMap<String> {
		// var aSelectedAction = event.action_list.map((item) -> {
		// 	return item.action_id;
		// });
		var m :StringMap<String> = [
			'damage' => 'Damage',
			'aspect_applier' => 'Status applier',
		];
		// for (k in m.keys()) {
		// 	if( aSelectedAction.indexOf(k) != -1) {
		// 		m.remove(k);
		// 	}
		// }
		return m;
	}
	public function removeAction(el :Element) {
		el.closest('fieldset').remove();
	}

	public function addAction(el :Element) {
		var root = el.closest('[data-dyn-tpl]');

		var select :SelectElement = cast root.querySelector('[data-inputaspect-select-action]');

		var wrapper = root.querySelector('[data-action-list]');
		var item = renderTemplate( getTemplateItem().execute({uid: _uid}) );
		wrapper.append(item);

		item
			.querySelector('[data-placeholder]')
			.replaceWith( createForm( select.value ).getDomElement() );
	}

	static public function getTemplate() {
        return new Template(Resource.getString('form.input_aspect'));
    }

	static public function getTemplateItem() {
        return new Template(Resource.getString('form.input_listaspect_item'));
    }

	public function createForm(s :String) :IView {
		switch( s ) {
			case 'damage': return new FormAttack();
			case 'applier': return new FormAspectApplier();
		}
		throw 'invalid "'+s+'"';
	}

	public function render() :String {
		var option = [];
		for ( k => v  in getActionOptionMap()) {
			option.push({label: v, value: k});
		}
        return getTemplate().execute({
			label: _label,
			uid: _uid,
			action_option_list: option,
		});
    }
}