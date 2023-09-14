package animix.event;

import animix.action.IAction;

typedef ActionPromptContext = {
	var action :Array<IAction>;
	var side :Bool;
};