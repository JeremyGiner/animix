package ultcom.view.gui;

import ultcom.component.ds.UnitType;
import h2d.Flow;
import hxd.Event;
import h2d.Interactive;
import h2d.Text;
import h2d.Graphics;
import h2d.Object;
import ultcom.Main;

class ButtonUnitType extends ButtonIcon {
	
	public function new( 
		oUnitType :UnitType, 
		oApp :Main, oData :Dynamic, 
		?parent :Null<Object> 
	) {
		var oIcon = new UnitTypeView( oUnitType, 0x666666 );
			oIcon.setScale(20);
		super(oIcon,oApp,oData,parent);
	}
}