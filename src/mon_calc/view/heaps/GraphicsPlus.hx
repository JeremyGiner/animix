package ultcom.view.heaps;

import h2d.Graphics;

class GraphicsPlus extends Graphics {
	
	public function drawCirclePlus( cx : Float, cy : Float, radius : Float, nsegments = 0, offset :Float = 0 ) {
		flush();
		if( nsegments == 0 )
			nsegments = Math.ceil(Math.abs(radius * 3.14 * 2 / 4));
		if( nsegments < 3 ) nsegments = 3;
		var angle = Math.PI * 2 / nsegments;
		for( i in 0...nsegments + 1 ) {
			var a = i * angle + offset;
			lineTo(cx + Math.cos(a) * radius, cy + Math.sin(a) * radius);
		}
		flush();
	}
}