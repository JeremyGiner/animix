package animix_client_js.client.form;

import animix.action.AniSwitchAction;
import animix.action.AniMoveAction;
import js.html.Element;
import js.html.Event;
import animix.state.AniActionState;

class ActionChoiceWidget extends AView {
	
	var _oState :AniActionState;
	var _fn :Int->Void;
	
	public function new( oState :AniActionState, fn :Int->Void ) {
		_oState = oState;
		_fn = fn;
		super();

		var sMove = '';
		for( k => v in _oState.getRedActionAr().keyValueIterator() ) {
			if (Std.isOfType(v, AniMoveAction)) {
				var oAction :AniMoveAction = cast v;
				sMove += '<button type="button" class="btn btn-primary" data-actionbtn="'+k+'">'
					+ oAction
						.getMove( _oState.getBattle() )
						.getLabel()
					+ '</button>';
				continue; 
			}
		}

		var sSwitch = '';
		for( k => v in _oState.getRedActionAr().keyValueIterator() ) {
			if (Std.isOfType(v, AniSwitchAction)) {
				var oAction :AniSwitchAction = cast v;
				sSwitch += '<button type="button" class="btn btn-primary" data-actionbtn="'+k+'">'
					+ 'Switch to '
					+ oAction
						.getAni( _oState.getBattle() )
						.getLabel()
					+ '</button>';
				continue; 
			}
		}

		_dom.innerHTML = '<div class="row">
			<div class="col">' 
			+ sMove 
			+'</div>
			<div class="col">' 
			+ sSwitch 
			+'</div>
		</div>';

		_dom.addEventListener('click', function(oEvent :Event) {
			if( !Std.is(oEvent.target,Element) ) return;
			var oElement :Element = cast oEvent.target;
			if( !oElement.hasAttribute('data-actionbtn') ) return;
			_fn(
				Std.parseInt( 
					oElement.getAttribute('data-actionbtn')
				)
			);
			
		});
	}
}