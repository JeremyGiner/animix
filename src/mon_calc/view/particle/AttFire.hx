package ultcom.view.particle;

import legion.client.core.HeapsApp;
import hxd.snd.OggData;
import h2d.Graphics;
import space.Vector2f;
import legion.client.view.AParticle;

class AttFire extends AParticle {
	
	public function new( oBegin :Vector2f, oEnd :Vector2f ) {
		super( 1000 );

		this.setPosition( oBegin.x, oBegin.y );

		var oGrph = new Graphics( this );
		oGrph.beginFill();
		oGrph.lineStyle(0.1,0xFFFFFF);
		oGrph.lineTo(0,0);
		oGrph.lineTo( oEnd.x - oBegin.x, oEnd.y - oBegin.y);
		oGrph.endFill();

	}

}