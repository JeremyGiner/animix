package format.gfx;

import svg.EJoinStyle;
import svg.ECapsStyle;

class LineStyle
{
   public var thickness:Float;
   public var color:Int;
   public var alpha:Float;
   public var pixelHinting:Bool;
   //public var scaleMode:LineScaleMode;
   public var capsStyle:ECapsStyle;
   public var jointStyle:EJoinStyle;
   public var miterLimit:Float;

   public function new()
   {
      thickness = 1.0;
      color = 0x000000;
      alpha = 1.0;
      pixelHinting = false;
      //scaleMode = LineScaleMode.NORMAL;
      capsStyle = ECapsStyle.ROUND;
      jointStyle = EJoinStyle.ROUND;
      miterLimit = 3.0;
   }
}
