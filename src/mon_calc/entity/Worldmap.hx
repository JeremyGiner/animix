package ultcom.entity;

import space.Vector2i;
import space.AlignedAxisBox2i;
import legion.core.entity.AEntity;

class Worldmap extends AEntity {
	
	var _oLimit :AlignedAxisBox2i;

	public function new() {
		_oLimit = new AlignedAxisBox2i( 200, 200, new Vector2i(0,0) );
		super();
	}

	public function getLimit() :space.AlignedAxisBox2i {
		return _oLimit;
	}
}