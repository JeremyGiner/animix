package animix.ds;

enum abstract EEventType(Int) {
	var OnActionPrompt;
	var OnTurnStart;

	var OnAffinityCalc;
	var OnStatCalc;

	var OnMoveCalc;

	var OnAttack;

	var OnHealPre;
	var OnHealPost;
	
	var OnDamageCalc;
	var OnDamagePre;
	var OnDamagePost;

	// OnAspectEntryPre;
	// OnAspectEntryPost;
	// OnAspectExecutePre;
	// OnAspectExecutePost;

	var OnItemRemove;

	var OnSwitchIn; // Post switch
	var OnSwitchOut; // Pre switch

	var OnTurnEnd;
}