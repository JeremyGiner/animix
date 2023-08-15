package mon_calc.core;

interface IObserver<CSubject> {
	public function notify( o :CSubject ) :Void;
}