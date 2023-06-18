package ultcom.view.gui;

import legion.client.core.HeapsApp;
import h2d.Flow;
import h2d.Graphics;
import h2d.Object;

class MenuView extends Flow {

	public function new( ?parent :Object ) {
		super( parent );
		this.layout = FlowLayout.Vertical;
		this.reverse = true;
		this.padding = 10;
		this.addChild( createFrame() );
		this.update();
	}

	public function createFrame() {
		var oRect = this.getBounds();
		var o = new Graphics();
		o.beginFill(0x888888,1);
		o.drawRect(0,0,100,100);
		o.endFill();
		return o;
	}

	public function update() {
		
		// Update position
		var oWindow = hxd.Window.getInstance();
		this.setPosition( 
			- oWindow.width / 2,
			oWindow.height / 2 - this.getBounds().height 
		);
	}
}