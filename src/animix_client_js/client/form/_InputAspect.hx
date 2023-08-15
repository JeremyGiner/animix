package animix_client_js.client.form;

import js.html.MouseEvent;
import haxe.Resource;
import animix_client_js.Template;
import js.html.Element;
import mon_calc.core.aspect.IAspect;
import mon_calc.core.effect.IEffect;
import haxe.ds.StringMap;
import js.html.SelectElement;

typedef AspectItem = {
	label: String,
	action_id: String,
};

class InputAspect extends AViewComposite implements IForm<IAspect>  {

	var client :Client;
	var label :String;
	var aspect: IAspect;
	
	public function new(label :String, name :String) {
		super([
			new InputSelect('Aspect', 'aspect',[
				'attack' => 'Attack',
				'aspect_applier' => 'Status applier',
			])
		]);
		aspect = null;
	}

	public function getValue() {
		return aspect;
	}

	public function onClick( event :MouseEvent ) {

		if( ! Std.isOfType( event.target, Element ) ) return;
		var el :Element = cast event.target;

		// TODO : render action list
		var root = el.closest('[data-dyn-tpl]');
		var iViewId = Std.parseInt(root.getAttribute('data-dyn-tpl'));
		var elEvent = el.closest('[data-event]');

		var select :SelectElement = cast elEvent.querySelector('[data-inputaspect-select-action]');
		var event_id = elEvent.getAttribute('data-event');
		this._data.event_list.filter((event) -> event.event_id == event_id)
			[0].action_list.push({
				label: select.value,
				action_id: select.value,
			});

		root.outerHTML = this.render();
	}

	static public function getTemplate() {
        return new Template(Resource.getString('form.input_aspect'));
    }

	static public function InputAspect_add_action(
		client :Client,
		el :Element
	) {

		// TODO : render action list
		var root = el.closest('[data-dyn-tpl]');
		var iViewId = Std.parseInt(root.getAttribute('data-dyn-tpl'));
		var input :InputAspect = cast client
			.getRoot()
			.getChild(iViewId);
		var elEvent = el.closest('[data-event]');

		var select :SelectElement = cast elEvent.querySelector('[data-inputaspect-select-action]');
		var event_id = elEvent.getAttribute('data-event');
		input._data.event_list.filter((event) -> event.event_id == event_id)
			[0].action_list.push({
				label: select.value,
				action_id: select.value,
			});

		root.outerHTML = input.render();
	}

	override public function render() :String {
        return getTemplate().execute(getRenderData());
    }

	public function getAspectForm(s :String) :IForm<IAspect> {
		switch( s ) {
			case 'attack': return new FormAttack();
			//case 'applier': return new FormAspectApplier();
		}
		throw 'invalid "'+s+'"';
	}
}