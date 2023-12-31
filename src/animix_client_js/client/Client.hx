package animix_client_js.client;

import animix_client_js.client.form.IView;
import js.Browser;

class Client {

	var _root :IView;

	public function new() {

		// TODO : render team builder
		_root = null;
		untyped Browser.window.Client = this;


		// Browser.document.addEventListener('click', (event :MouseEvent) -> {
		// 	if(! Std.isOfType(event.target,Element) ) return;
		// 	var el = cast(event.target,Element);
		// 	el = el.closest('[data-dyn-tpl]');
		// 	var compo = _root.getChild(
		// 		Std.parseInt(el.getAttribute('[data-dyn-tpl]'))
		// 	);

		// 	if( Std.isOfType(compo, IOnClick) ) {
		// 		cast(compo, IOnClick).onClick(event);
		// 	}

		// 	if(! el.hasAttribute('data-click') ) return;
		// 	var action = el.getAttribute('data-click');
		// 	switch(action) {
		// 		case 'InputAspect_add_action': InputAspect.InputAspect_add_action(
		// 			this,
		// 			el
		// 		);
		// 		case 'InputAspect_add_event': InputAspect.InputAspect_add_event(
		// 			this,
		// 			el
		// 		);
		// 		default:
		// 	}
		// });
	}

	public function getRoot() {
		return _root;
	}

	public function renderDyna(oView :IView) {
		
		var holder = Browser.document.body;
		holder.innerHTML = '';
		holder.append(oView.getDomElement());

		_root = oView;
	}

	/**
	 * @deprecated
	 */
	public function getClientChild( uid :Int ) :IView {
		var el = _root.getDomElement().querySelector('[data-client-id="'+uid+'"]');
		return untyped el.hxComponent;
    }

}