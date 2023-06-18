package ultcom.view.gui;

import trigger.Subject;
import trigger.IObserver;
import ultcom.component.ds.UnitType;
import h2d.Text;
import ultcom.component.Unit;
import legion.core.entity.IEntity;
import ultcom.component.BuildQueue;
import h2d.Object;
import h2d.Flow;

class BuildQueueView extends Flow implements IObserver<Dynamic>{

	var _oApp :Main;
	var _oObservedUnit :IEntity;
	
	public function new( oApp :Main, ?parent :Object ) {
		super( parent );
		padding = 10;
		layout = Vertical;
		backgroundTile = h2d.Tile.fromColor(0x666666);
		_oApp = oApp;
		_oObservedUnit = null;
		update();
	}

	public function update() {
		// Reset
		removeChildren();
		if( _oObservedUnit != null )
			_oObservedUnit.onComponentUpdate.remove( cast this );

		// 
		var aSelected = _oApp.getUnitSelection().getBuildingQueueEntity();
		if( aSelected.length == 0 ) return;

		var oEntity = aSelected[0];
		_oObservedUnit = oEntity;
		_oObservedUnit.onComponentUpdate.attach( cast this );
		var oBuildQueue :BuildQueue = oEntity.getComponent(BuildQueue);
		if( oBuildQueue == null ) return;

		//_____________________________
		// Draw add btns
		var oSectionAdd = new Flow( this );
		oSectionAdd.backgroundTile = h2d.Tile.fromColor(0x888888);
		var oUnit :Unit = oEntity.getComponent(Unit);
		for( sUnitTypeId in oUnit.getType().getAvailableUnitBuild() ) {
			var oWrapper = new Flow( oSectionAdd );
			oWrapper.padding = 10;
			var oUnitType = _oApp.getUnitType( sUnitTypeId );
			new ButtonUnitType(oUnitType,_oApp,{
				action: 'train_unit',
				entity: oEntity.getId(),
				unit_type: sUnitTypeId,
			},oWrapper);
		}

		//_____________________________

		var oSectionQueue = new Flow( this );
		oSectionQueue.padding = 2;
		oSectionQueue.borderBottom = 1;

		var oCurrent = oBuildQueue.getCurrent();
		if( oCurrent == null ) {
			var oText = new Text( hxd.res.DefaultFont.get(), oSectionQueue );
			oText.text = 'Idle';
			return;
		}

		//_____________________________

		var oStatusSection = new Flow( oSectionQueue );
		oStatusSection.layout = Vertical;
		var oBtn = new ButtonUnitType(oCurrent,_oApp,{
			action: 'train_unit_stop',
			entity: oEntity.getId(),
			queue: 'current',
		},oStatusSection);
		var o = new Gauge(oStatusSection, 0xFFFF00);
		o.setPercent( oBuildQueue.getPercentDone() );
		o.scaleY = oBtn.getBounds().height / 10;
		o.scaleX = oBtn.getBounds().width;

		//_____________________________

		for ( i => oType in oBuildQueue.getOnceQueue() ) {
			var oWrapper = new Flow( oSectionQueue );
			oWrapper.padding = 10;
			new ButtonUnitType(oType,_oApp,{
				action: 'train_unit_stop',
				entity: oEntity.getId(),
				queue: 'once',
				index: i,
			},oWrapper);
		}
		for ( i => oType in oBuildQueue.getRepeatQueue() ) {
			var oWrapper = new Flow( oSectionQueue );
			oWrapper.padding = 10;
			new ButtonUnitType(oType,_oApp,{
				action: 'train_unit_stop',
				entity: oEntity.getId(),
				queue: 'repeat',
				index: i,
			},oWrapper);
		}

		
		
	}
//_____________________________________________________________________________

	public function signal( o :Subject<Dynamic> ) {
		update();
	}
}