package animix_client_js.client.form;


class AViewComposite extends AView implements IViewComposite {

	var _child :Array<IView>;

    public function new(a :Array<IView>) {
        super();
		_child = a;
		for( el in a)
			_dom.append(el.getDomElement());
    }
    
    public function getClientChild( uid :Int ) :IView {
		return untyped _dom.querySelector('[data-client-id="'+uid+'"]').hxComponent;
    }
}