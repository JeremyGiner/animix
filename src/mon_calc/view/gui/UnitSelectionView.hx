package ultcom.view.gui;

import h2d.Flow;
import hxd.Event;
import trigger.Subject;
import ultcom.component.ds.UnitType;
import haxe.ds.Map;
import ultcom.component.Unit;
import legion.core.entity.IEntity;
import trigger.IObserver;
import ultcom.client.model.UnitSelection;
import h2d.Object;

class UnitSelectionView extends Flow implements IObserver<Dynamic> {

	var _oUnitSelection :UnitSelection;

	public function new( oUnitSelection :UnitSelection, ?parent :Object ) {
		super( parent );
		this.layout = FlowLayout.Vertical;
		this.reverse = true;
		this.padding = 10;
		_oUnitSelection = oUnitSelection;
		_oUnitSelection.onUpdate.attach( cast this );
		
		update();
	}

	public function update() {

		var oApp = _oUnitSelection.getApp();
		var aUnitId = _oUnitSelection.getUnitIdAr();

		// Index by UnitType
		var mEntByUnitType = new Map<UnitType,Array<IEntity>>();
		for( id in aUnitId ) {
			var oEntity = oApp.getGameState().getEntity( id );
			if( oEntity == null ) continue;
			var oUnit :Unit = oEntity.getComponent(Unit);
			var oType = oUnit.getType();
			if( !mEntByUnitType.exists( oType ) )
				mEntByUnitType.set( oType, [] );
			mEntByUnitType.get( oType ).push( oEntity );
		}

		// Redraw everything
		this.removeChildren();
		var i = 0;
		var oSelectSection = new Flow( this );
		for( oType => aEntity in mEntByUnitType ) {
			var oBtn = new Button(
				oType.getLabel() + ' ' + aEntity.length,
				oApp,
				{action: 'select_type', unit_type: oType.getId() },
				oSelectSection
			);
		}

		// build menu
		var oSectionBuild = new Flow( this );
		for( oType in _oUnitSelection.getAvailableBlueprint() ) {
			var oBtn = new Button(
				'Build '+ oType.getLabel(),
				oApp,
				{action: 'build_building', unit_type: oType.getId() },
				oSectionBuild
			);
		}

		// Case : has buildqueue
		var aBuildQueueEntity = _oUnitSelection.getBuildingQueueEntity();
		if( aBuildQueueEntity.length != 0 ) {
			new BuildQueueView( oApp, this );
		}
	}

	public function signal( o :Subject<Dynamic> ) {

		update();
		
	}

}