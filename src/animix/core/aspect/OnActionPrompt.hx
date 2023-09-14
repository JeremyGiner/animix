package animix.core.aspect;

import animix.ds.Context;
import mon_calc.core.effect.IEffect;
import animix.event.ActionPromptContext;

interface OnActionPrompt extends IEffect<ActionPromptContext> {
	public function getPriority() :String;
}