using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;

module OwlShapes{
	var x = 93;
    var y = 39;
    var w = 10;
    var h = 4;
    var offset = 1;
    var penWidth = 1;
    
	function drawShutEyes(dc){
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(26, 36, 35, 5);
	}
	
	function drawWideEyes(dc){
		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(30, 40, 2);
    	dc.fillCircle(55, 40, 2);
	}
	
	function drawEyesInPosition(dc, position){

    	if (position == 0)
    	{
			drawWideEyes(dc);
    	}
    	else
    	{
    		drawShutEyes(dc);    	
    	}
	}
}