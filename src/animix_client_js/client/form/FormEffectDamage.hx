package animix_client_js.client.form;

import animix.ds.EDamageElement;


class FormEffectDamage extends AViewComposite {

    public function new( action_id :Int ) {
        super([
            new InputSelect(
                'Element',
                'action[' + action_id + '][element]',
                [
                    EDamageElement.Water,
                    EDamageElement.Fire,
                    EDamageElement.Air,
                    EDamageElement.Earth,
                    EDamageElement.Electric,
                ]
            ),
            new InputAspect('Effect', 'aspect'),
        ]);
    }

	public function validate() {
		return true;
	}

    
}