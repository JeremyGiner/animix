package ultcom.view;

import legion.client.core.HeapsApp;
import h2d.Graphics;
import ultcom.component.ds.UnitType;
import h2d.Object;
import ultcom.view.heaps.GraphicsPlus;

class UnitTypeView extends Object {
	
//_____________________________________________________________________________
//	Constructor
	
	public function new( 
		o :UnitType, 
		iColor :Int, iColorOutline :Int = 0x000000, 
		?parent :Object 
	) {

		super( parent );

		// draw body
		addChild( createBody(o, iColor, iColorOutline) );
	}

//_____________________________________________________________________________
//	Sub-routine


	public function createBody( oType :UnitType, iColor :Int, iColorOutline :Int ) {
		
		var _oBody = new GraphicsPlus();

		//__________________
		// Default box
		
		_oBody.beginFill(iColor, 1);
		_oBody.lineStyle( 0.1, iColorOutline);

		if( oType.is( Building ) )
			_oBody.drawCircle( 0, 0, 1, 6 );
		else if( oType.is( Air ) )
			_oBody.drawCirclePlus( 0, 0, 1.2, 3, -Math.PI / 2 );
		else
			_oBody.drawCirclePlus( 0, 0, 1, 4, Math.PI / 4 );

		_oBody.endFill();


		var oContent = createContent( oType, iColorOutline );
		if( oContent != null ) {
			//oContent.setPosition( -1, -1 );
			oContent.setScale( 0.5 );
			oContent.rotate( Math.PI / 2 );
			_oBody.addChild( oContent );
		}
		
		return _oBody;
	}

	public function createContent( oType :UnitType, iColorOutline :Int ) {
		var o = new GraphicsPlus();
		var oAtt = oType.getAttackType();

		//__________________
		
		o.beginFill(iColorOutline, 1);

		if( oType.is( BuildT1 ) ) {
			o.drawCircle(0,0,1,3);
			o.drawCircle(0,0,1,4);
			o.endFill();
			return o;
		}

		if( oAtt == null ) return null;

		
		if( oAtt.getTargetType() == Ground ) {
			o.drawCircle(0,0,1,4);
			o.endFill();
			return o;
		}

		if( oAtt.getTargetType() == Air ) {
			o.drawCircle(0,0,1,3);
			o.endFill();
			return o;
		}
		return null;
	}
}