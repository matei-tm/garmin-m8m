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
    
	function drawShutEyes(dc, owlPositionX){
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(owlPositionX + 21, 36, 35, 5);
	}
	
	function drawWideEyes(dc, alertColor, owlPositionX){
		dc.setColor(alertColor, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(owlPositionX + 25, 40, 2);
    	dc.fillCircle(owlPositionX + 50, 40, 2);
	}
	
	function drawEyesInPosition(dc, eyesClosed, alertColor, owlPositionX){
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		dc.fillCircle(owlPositionX + 25, 40, 4);
    	dc.fillCircle(owlPositionX + 50, 40, 4);
    	
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.fillCircle(owlPositionX + 25, 40, 2);
    	dc.fillCircle(owlPositionX + 50, 40, 2);		

		
    	if (eyesClosed == 0)
    	{
			drawWideEyes(dc, alertColor, owlPositionX);
    	}
    	else
    	{
    		drawShutEyes(dc, owlPositionX);    	
    	}
	}
}