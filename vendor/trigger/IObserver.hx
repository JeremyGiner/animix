package trigger;

/**
 * @author 
 */
interface IObserver<C> {
	public function signal( o :Subject<C> ) :Void;
}