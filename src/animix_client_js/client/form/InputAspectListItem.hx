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

class InputAspectListItem extends AView {

	var _parent_uid :Int;
	var _item :Int;
	
	public function new(parent_uid :Int, item :AView) {
		super();
		_parent_uid = parent_uid;
		this.innerHTML = render();
	}

	public function getItem() {

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

	public function getRenderData() {
		var option = [];
		for ( k => v  in getActionOptionMap()) {
			option.push({label: v, value: k});
		}
		return {
			label: _label,
			uid: getId(),
			action_option_list: option,
			child_list: _aChild.map((child) -> {
                return {
                    tpl: child.render(),
                };
            }),
		};
	}

	public function addAction(el :Element) {
		
		// TODO : render action list
		var root = el.closest('[data-dyn-tpl]');
		var input = this;
		var elEvent = el.closest('[data-event]');

		var select :SelectElement = cast root.querySelector('[data-inputaspect-select-action]');
		var event_id = elEvent.getAttribute('data-event');
		_aChild.push( createForm(select.value) );

		root.outerHTML = input.render();
	}

	static public function getTemplate() {
        return new Template(Resource.getString('form.input_aspect'));
    }

	public function createForm(s :String) :IForm<IAspect> {
		switch( s ) {
			case 'attack': return cast new FormAttack();
			case 'applier': return cast new FormAspectApplier();
		}
		throw 'invalid "'+s+'"';
	}

	public function getAspectForm(s :Class<IAspect>) :IForm<IAspect> {
		if( Std.isOfType(s, MoveDamage) ) return new FormAttack();
		throw 'invalid "'+s+'"';
	}

	override public function render() :String {
        return getTemplate().execute(getRenderData());
    }
}