package trigger;

/**
 * ...
 * @author 
 */
class Subject<CEvent> {
	
	var _a :List<IObserver<CEvent>>;
	var _oEvent :CEvent;

	public function new() {
		_a = new List();
		_oEvent = null;
	}
	
	public function attach( fn :IObserver<CEvent> ) {
		_a.push( fn );
	}
	
	public function remove( fn :IObserver<CEvent> ) {
		_a.remove( fn );
	}
	
	public function getEvent() :CEvent {
		return _oEvent;
	}
	
	public function notify( oEvent :CEvent ) {
		_oEvent = oEvent;
		for ( fn in _a )
			fn.signal( this );// TODO : fix compile error
		_oEvent = null;
	}
}