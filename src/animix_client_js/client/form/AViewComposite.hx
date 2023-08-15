package animix_client_js.client.form;


class AViewComposite extends AView implements IViewComposite {

    public function new(a :Array<IView>) {
        super();
		for( el in a)
			_dom.append(el.getDomElement());
    }
    
    public function getClientChild( uid :Int ) :IView {
		return untyped _dom.querySelector('[data-client-id="'+uid+'"]').hxComponent;
    }
}