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
	
	function drawWideEyes(dc, alertColor){
		dc.setColor(alertColor, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(30, 40, 2);
    	dc.fillCircle(55, 40, 2);
	}
	
	function drawEyesInPosition(dc, position, alertColor){

    	if (position == 0)
    	{
			drawWideEyes(dc, alertColor);
    	}
    	else
    	{
    		drawShutEyes(dc);    	
    	}
	}
}