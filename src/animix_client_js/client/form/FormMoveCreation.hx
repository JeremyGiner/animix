package animix_client_js.client.form;

import js.html.InputElement;
import animix_client_js.client.form.Input;


class FormMoveCreation extends AViewComposite {

    public function new() {
        super([
			new Input('Move label', 'label'),
			new Input('Move element', 'element'),
            new InputAspectList('Effect'),
        ]);
    }

    
}