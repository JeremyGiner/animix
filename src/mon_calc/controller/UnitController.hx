package ultcom.controller;

import ultcom.action.TrainUnit;
import trigger.Subject;
import trigger.IObserver;
import ultcom.client.model.UnitSelection;
import h2d.col.Point;
import ultcom.action.BuildAction;
import ultcom.tool.UnitFactory;
import ultcom.view.BaseView;
import ultcom.entity.Entity;
import h2d.Object;
import ultcom.component.Guidance;
import legion.core.component.Position;
import legion.core.GameState;
import h2d.Graphics;
import space.Vector2f;
import hxd.Event.EventKind;
import legion.client.core.HeapsApp;
import ultcom.system.RenderSystem;
import ultcom.view.gui.IButton;

/**
 * ...
 * @author 
 */
class UnitController implements IObserver<IButton> {

	var _oSelectionGui :Graphics;
	var _oBuildGui :Object;
	var _sBuildType :String;

	var _oMain :Main;

	var _oView :HeapsApp;
	var _oGame :GameState;

	var _oMouseRel :Point;
	
	public function new( oMain :Main, oGame :GameState ) {

		_oSelectionGui = null;
		_sBuildType = null;
		_oMain = oMain;
		_oView = oMain;
		_oGame = oMain.getGameState();

		_oMain.onButtonClick.attach( this );

		var inter = _oMain.getBgInteraction();
		inter.cursor = Default;
		
		inter.onPush = function( event :hxd.Event ) {
			getMousePos();

			// On push left click
			if ( 
				_oBuildGui == null 
				&& event.kind == EventKind.EPush 
				&& event.button == 0 
			) return selectStart( _oMouseRel.x, _oMouseRel.y );
		};
		inter.onMove = function( event :hxd.Event ) {
			getMousePos();
			// On move selection
			if ( 
				_oSelectionGui != null
				&& event.kind == EventKind.EMove 
				&& event.button == 0 
			) return selectGuiUpdate( _oMouseRel.x, _oMouseRel.y );

			// On move
			if ( 
				_oBuildGui != null
				&& event.kind == EventKind.EMove 
				&& event.button == 0 
			) return buildOrderUpdate();
		};
		inter.onRelease = function( event :hxd.Event ) {
			getMousePos();

			// On release left click
			if ( _oSelectionGui != null && event.button == 0 )
				return selectEnd( _oMouseRel.x, _oMouseRel.y );

			if ( _oBuildGui != null ) return endBuildOrder();
		};


		hxd.Window.getInstance().addEventTarget(function( event :hxd.Event ) {
			
			getMousePos();


			//_________________________

			// On push right click
			if ( event.kind == EventKind.EPush && event.button == 1 )
				return orderUnit();

			//_________________________
			

			
		});
	}


//_____________________________________________________________________________
// Observer

	public function signal( o :Subject<IButton> ) {

		var oBtnAction = o.getEvent().getData();
		trace(oBtnAction);
		switch( oBtnAction.action ) {
			case 'select_type':
				
				_oMain.getUnitSelection().reduceByType( oBtnAction.unit_type );
				return;
			case 'build_building':
				return startBuildOrder( oBtnAction.unit_type );
			case 'train_unit':
				_oMain.processAction( new TrainUnit( 
					oBtnAction.entity, 
					_oMain.getUnitType( oBtnAction.unit_type ),
					false
				) );
			case 'train_stop_current':
				// _oMain.processAction( new TrainUnit( 
				// 	oBtnAction.entity, 
				// 	_oMain.getUnitType( oBtnAction.unit_type ),
				// 	false
				// ) );
		}
		// CHeck if btn
		// get action 
		// if action 'select type' -> fiter selecti on by type
	}


//_____________________________________________________________________________
// Sub-routine

	function createGui( fSize :Float ) {
		var o = new Graphics();
		o.beginFill(0x000000, 0);
		o.lineStyle(0.1, 0xFFFFFF);
		o.drawCircle( 0, 0, fSize, 100 );
		o.endFill();
		return o;
	}

	function selectStart( x :Float, y :Float ) {
		if( _oSelectionGui != null ) {
			_oView.getScene().removeChild( _oSelectionGui );
		}
		_oSelectionGui = createGui( 0.0001 );
		_oSelectionGui.setPosition( x, y );
		_oView.getScene().addChild( _oSelectionGui );
	}

	function selectGuiUpdate( x :Float, y :Float ) {
		var oCenter = new Vector2f( _oSelectionGui.x, _oSelectionGui.y );
		var o = new Vector2f(
			x - _oSelectionGui.x,  
			y - _oSelectionGui.y 
		);

		// Redraw selection
		_oView.getScene().removeChild( _oSelectionGui );
		_oSelectionGui = createGui( o.length_get() );
		_oSelectionGui.setPosition( oCenter.x, oCenter.y );
		_oView.getScene().addChild( _oSelectionGui );
		
	}
	
	function selectEnd( x :Float, y :Float ) {
		
		var oCenter = new Vector2f( _oSelectionGui.x, _oSelectionGui.y );
		var fDist = new Vector2f(
			x - oCenter.x,  
			y - oCenter.y 
		).length_get();

		// Get entity seleted
		var a = new Array<Int>();
		for( o in _oGame.getEntityAll() ) {
			var pos :Position = o.getComponent( Position );
			if( pos == null ) continue;
			if( Vector2f.distance( pos, oCenter ) > fDist ) continue;
			a.push( o.getId() );
		}

		_oMain.getUnitSelection().set( a );

		_oView.getScene().removeChild( _oSelectionGui );
		_oSelectionGui = null;
	}

	function orderUnit() {
		for( id in _oMain.getUnitSelection().get() ) {

			var oEntity = _oGame.getEntity( id );
			if( oEntity == null ) continue;

			var oGuidance :Guidance = oEntity.getComponent(Guidance);
			if( oGuidance == null ) continue;
			// TODO : add if shift pressed

			oGuidance.setWaypoint( new Vector2f(
				_oMouseRel.x,
				_oMouseRel.y
			));
		}
	}

//_____________________________________
// Build

	function startBuildOrder( sType :String ) {
		_sBuildType = sType;

		if( _oMain.getUnitSelection().get().length == 0 ) return;

		// Create a fake entity to get its view
		var oFakeEntity = new UnitFactory(
			_oMain.getUnitType(_sBuildType), 0, 0, _oMain.getPlayerCurrent()
		).create();

		// draw unit preview under the mouse
		_oBuildGui = new BaseView( oFakeEntity );
		_oBuildGui.setPosition( 
			_oMouseRel.x,
			_oMouseRel.y
		);

		_oView.getScene().addChild( _oBuildGui );
		// TODO : update color (red nok)
	}

	function buildOrderUpdate() {
		// move grphics under the mouse
		_oBuildGui.setPosition( 
			_oMouseRel.x,
			_oMouseRel.y
		);
		
		// TODO : update color (red nok)
	}

	function endBuildOrder() {
		if( _sBuildType == null ) return;
		// TODO : if position nok -> do nothing
		// Create action

		_oView.getScene().removeChild( _oBuildGui );
		_oBuildGui = null;
		

		if( _oMain.getUnitSelection().get().length == 0 ) return;

		var oAction = new BuildAction( 
			_oMain.getUnitSelection().get()[0],//TODO : get selected
			_oMain.getUnitType(_sBuildType),
			new Vector2f( _oMouseRel.x, _oMouseRel.y )
		);
		_sBuildType = null;

		_oMain.processAction( oAction );
	}


//_____________________________________________________________________________
// Sub-routine

	function getMousePos() {
		var oScene = _oView.getScene();
		return _oMouseRel = oScene.globalToLocal(new Point(
			oScene.getScene().mouseX,
			oScene.getScene().mouseY
		));
	}
}