package ultcom.entity;

import legion.core.entity.AEntity;

class Player extends AEntity {

	var _sName :String;
	var _iColor :Int;

	public function new( name :String, color :Int ) {
		_sName = name;
		_iColor = color;
		super();
	}

	public function getName() { return _sName; }
	public function getColor() { return _iColor; }

}