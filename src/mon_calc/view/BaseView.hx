package ultcom.view;

import ultcom.component.Blueprint;
import legion.core.entity.IEntity;
import h2d.Text;
import h2d.Graphics;
import legion.core.component.Position;
import legion.client.view.AEntityView;

class BaseView extends AEntityView {


	
//_____________________________________________________________________________
//	Constructor
	
		
	public function new( o :IEntity ) {
		super( o );
		
		//_oContainer.addChild( DebugTool.createAnchor() );
		
		// draw body
		
		addChild( createBody() );
		
	}

	override function update( f :Float ) {
		// TODO : update on change
		var oPos :Position = _oOwner.getComponent(Position);
		if( oPos == null ) return;
		_updatePosition( oPos );
	}

	public function getBodyColor() :Int {
		if( this._oOwner.hasComponent(Blueprint) )
			return 0x6666FF;
		return 0x666666;
	}


	public function createBody() {
		
		
		var _oBody = new Graphics();
		
		//__________________
		// Default box
		
		_oBody.beginFill(getBodyColor(), 1);
		_oBody.drawRect( -0.5,-0.5,1,1);
		_oBody.endFill();
		
		var tf = new Text(hxd.res.DefaultFont.get());
		tf.text = '#' + _oOwner.getId();
		tf.scale(0.1);
		tf.scaleY = -0.1;
		_oBody.addChild( tf );
		
		return _oBody;
	}
	
}