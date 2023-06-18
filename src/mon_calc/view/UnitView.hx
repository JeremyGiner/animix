package ultcom.view;

import ultcom.entity.Entity;
import trigger.Subject;
import legion.client.core.HeapsApp;
import h2d.Flow;
import ultcom.component.BuildQueue;
import trigger.IObserver;
import h2d.Object;
import ultcom.component.Attack;
import ultcom.component.Volume;
import ultcom.component.Unit;
import ultcom.component.Blueprint;
import legion.core.entity.IEntity;
import h2d.Text;
import h2d.Graphics;
import legion.core.component.Position;
import legion.client.view.AEntityView;
import legion.client.core.GameEvent;

class UnitView extends AEntityView implements IObserver<GameEvent> {


	var _oHealthGauge :Gauge;
	var _oBuildGauge :Gauge;
	
//_____________________________________________________________________________
//	Constructor
	
		
	public function new( o :Entity ) {
		_oHealthGauge = null;
		_oBuildGauge = null;

		super( o );

		o.onComponentUpdate.attach( this );
		
		//_oContainer.addChild( DebugTool.createAnchor() );
		
		// draw body
		
		

		var oVolume :Volume = _oOwner.getComponent(Volume);
		if( oVolume != null ) {
			this.scale( oVolume.getRadius() );
		}

		var oBarSection = new Flow( this );
		oBarSection.setPosition( -1, -1 );
		oBarSection.layout = Vertical;
		oBarSection.scaleX = 2;
		oBarSection.scaleY = -0.5;

		// Unit
		var oUnit :Unit = _oOwner.getComponent(Unit);
		if( oUnit != null ) {
			// Unit - health
			_oHealthGauge = new Gauge( oBarSection, 0x66FF66 );

			addChild( new UnitTypeView( 
				oUnit.getType(), 
				oUnit.getOwner().getColor(),
				0x000000
			) );
		}

		// Attack range
		var oAttack :Attack = _oOwner.getComponent(Attack);
		if( oAttack != null ) {
			addChild( createCircle( oAttack.getType().getRange() ) );
		}

		// 
		var oBQueue :BuildQueue = _oOwner.getComponent(BuildQueue);
		if( oBQueue != null ) {
			_oBuildGauge = new Gauge( oBarSection, 0xFFFF00 );
		}
	}

	override function update( f :Float ) {
		// TODO : update on change
		var oPos :Position = _oOwner.getComponent(Position);
		if( oPos == null ) return;
		_updatePosition( oPos );

		if( _oHealthGauge != null ) {
			var oUnit :Unit = _oOwner.getComponent(Unit);
			_oHealthGauge.setPercent( oUnit.getHealthPercent() );
		}
	}

	public function getBodyColor() :Int {
		if( this._oOwner.hasComponent(Blueprint) )
			return 0x6666FF;
		return 0x666666;
	}


	public function createBody() {
		
		
		var _oBody = new Graphics();
		
		var oUnit :Unit = _oOwner.getComponent(Unit);

		//__________________
		// Default box
		
		_oBody.beginFill(oUnit.getOwner().getColor(), 1);
		_oBody.lineStyle( 0.1, 0xFFFFFF);

		if( oUnit.getType().is( Building ) )
			_oBody.drawCircle( 0,0,1, 6 );
		else
			_oBody.drawRect( -1,-1,2,2);


		_oBody.endFill();
		
		var tf = new Text(hxd.res.DefaultFont.get());
		tf.text = '#' + _oOwner.getId();
		tf.scale(0.1);
		tf.scaleY = -0.1;
		_oBody.addChild( tf );
			

		
		return _oBody;
	}


	public function createCircle( fRadius :Float ) {
		
		var o = new Graphics();

		//__________________
		// Default box
		
		o.beginFill(0x000000, 0);
		o.lineStyle( 0.1, 0xFF0000);
		o.drawCircle( 0, 0, fRadius, 10 );
		o.endFill();

		
		return o;
	}

//_____________________________________________________________________________

	public function signal( o :Subject<GameEvent> ) {
		var oEvent = o.getEvent();
		if(Std.is(oEvent.component, BuildQueue)) {
			_oBuildGauge.setPercent( untyped oEvent.component.getPercentDone() );
		}
	}
	
}