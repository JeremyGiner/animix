package ultcom.view.gui;

import h2d.Flow;
import hxd.Event;
import h2d.Interactive;
import h2d.Text;
import h2d.Graphics;
import h2d.Object;
import ultcom.Main;

class ButtonIcon extends Flow implements IButton {

	var _oData :Dynamic;

	public function new( oIcon :Object, oApp :Main, oData :Dynamic, ?parent :Null<Object> ) {
		super(parent);

		this.padding = 10;
		this.backgroundTile = getBg();

		_oData = oData;

		this.enableInteractive = true;
		var oInter = this.interactive;
		oInter.cursor = Button;
		oInter.onPush = function( o :Event ) {
			oApp.onButtonClick.notify( this );
		};
		oInter.onOver = function(_) {
			trace('over');
			this.backgroundTile = getBgHover();
			trace(this.backgroundTile == getBgHover());
		}
		oInter.onOut = function(_) {
			trace('out');
			this.backgroundTile = getBg();
		}
		oInter.propagateEvents = false;
		
		// Re-center icon
		var oWrapper = new Flow(this);
		oWrapper.paddingLeft = 20;
		oWrapper.paddingTop = 20;
		oWrapper.minWidth = 20;
		oWrapper.minHeight = 20;
	
		oWrapper.addChild( oIcon );
	}

	public function getData() { return _oData; }



	static var oBg = null;
	static var oBgHover = null;
	public static function getBgHover() {
		if( oBgHover == null ) 
			oBgHover = h2d.Tile.fromColor(0xFFFFFF);
		return oBgHover;
	}
	public static function getBg() {
		if( oBg == null ) 
			oBg = h2d.Tile.fromColor(0xFFFF00);
		return oBg;
	}
	
}