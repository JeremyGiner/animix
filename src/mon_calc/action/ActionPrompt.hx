package mon_calc.action;

class ActionPrompt {

    var _aAction :Array<IAction>;
    var _iChoice :Null<Int>;

    public function new( aAction :Array<IAction> ) {
        _aAction = aAction;
        _iChoice = null;
    }

    public function getActionAr() { return _aAction; }
    public function getChoice() { return _iChoice; }

    public function choose( i :Int ) {
        if( i >= _aAction.length ) throw '!!!';
        _iChoice = i;
    }
}