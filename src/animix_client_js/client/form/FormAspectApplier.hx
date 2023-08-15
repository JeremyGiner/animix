package animix_client_js.client.form;

import animix.aspect.Poison;
import sweet.functor.builder.FactoryDefault;
import animix.aspect.MoveAspectApplier;
import mon_calc.core.aspect.IAspect;

class FormAspectApplier extends AViewComposite implements IForm<IAspect> {
    
    public function new() {
        super([
            new InputRange('Turn', 'turn', 0, 5),
            new InputSelect('Aspect', 'aspect', [
                'burn' => 'Burn',
                'poison' => 'Poison',
            ]),
        ]);
    }

	public function getValue() {
		return new MoveAspectApplier(new FactoryDefault<IAspect>(Poison,[
			1,
			1
		]));
	}
}