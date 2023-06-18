package mon_calc.ds;

enum EEventType {
	OnActionPrompt;
	OnTurnStart;

	OnAffinityCalc;
	OnStatCalc;

	OnMoveCalc;

	OnAttack;

	OnHealPre;
	OnHealPost;
	
	OnDamageCalc;
	OnDamagePre;
	OnDamagePost;

	OnAspectEntryPre;
	OnAspectEntryPost;
	OnAspectExecutePre;
	OnAspectExecutePost;

	OnItemRemove;

	OnSwitchIn; // Post switch
	OnSwitchOut; // Pre switch

	OnTurnEnd;
}