package ultcom.view.gui;

import h2d.Flow;
import hxd.Event;
import h2d.Interactive;
import h2d.Text;
import h2d.Graphics;
import h2d.Object;
import ultcom.Main;

class Button extends Object implements IButton {

	var _oData :Dynamic;
	
	public function new( s :String, oApp :Main, oData :Dynamic, ?parent :Null<Object> ) {
		super(parent);
		_oData = oData;
		var oText = new Text( hxd.res.DefaultFont.get() );
		oText.text = s;
		oText.setScale(1);
		addChild( createFrame( oText ) );
		addChild( oText );
		var oRect = oText.getBounds();
		var oInter = new Interactive(oRect.width,oRect.height);
		oInter.onPush = function( o :Event ) {
			trace('!!!!!!!!!');
			oApp.onButtonClick.notify( this );
		};
		oInter.propagateEvents = false;
		addChild( oInter );
	}

	public function getData() { return _oData; }

	public function createFrame( oText :Text ) {
		var oRect = oText.getBounds();
		var o = new Graphics();
		o.beginFill(0x666666,1);
		o.drawRect(0,0,oRect.width,oRect.height);
		o.endFill();
		return o;
	}
}