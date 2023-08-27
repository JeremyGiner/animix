package animix_client_js.client.form;

import js.Browser;


class Layout extends AView implements IViewComposite {

	var _child :Array<IView>;

    public function new(a :Array<IView>) {
        super();
		_child = a;
		_dom.classList.add('row');
		for( el in a) {
			var col = Browser.document.createElement('div');
			col.classList.add('col-auto');
			col.append(el.getDomElement());
			
			_dom.append(col);
		}
    }
    
    public function getClientChild( uid :Int ) :IView {
		throw '!!!';
		return untyped _dom.querySelector('[data-client-id="'+uid+'"]').hxComponent;
    }
}