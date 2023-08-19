package animix_client_js.client.form;

import animix.entity.Battle;

class FormMatchCreation extends AViewComposite implements IForm<Battle> {

	var oInputTeamRed :FormTeamCreation;
	var oInputTeamBlue :FormTeamCreation;


    public function new() {
        super([
            oInputTeamRed = new FormTeamCreation('Red'),
            oInputTeamBlue = new FormTeamCreation('Blue'),
        ]);
    }

	public function getValue() {
		return new Battle(
			oInputTeamRed.getValue(),
			oInputTeamBlue.getValue()
		);
	}

    
}