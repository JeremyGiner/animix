package ultcom.view;

import h2d.Graphics;
import h2d.Flow;
import h2d.Object;

class Gauge extends Flow {
	
	var _oBar :Graphics;

	public function new( ?parent :Object, iColor :Int ) {
		super( parent );
		backgroundTile = h2d.Tile.fromColor(0x000000);

		_oBar = new Graphics( this );
		_oBar.beginFill(iColor, 1);
		_oBar.drawRect( 0, 0, 1, 1 );
		_oBar.endFill();

	}

	public function setPercent( f :Float ) {
		_oBar.scaleX = f;
	}


}