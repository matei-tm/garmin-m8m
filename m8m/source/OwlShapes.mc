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
    
	function drawShutEyes(dc, owlPositionX, faceColor)
	{
		dc.setColor(faceColor, Gfx.COLOR_TRANSPARENT);
    	dc.fillRectangle(owlPositionX + 21, 36, 35, 5);
	}
	
	function drawWideEyes(dc, eyeColor, owlPositionX)
	{
		dc.setColor(eyeColor, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(owlPositionX + 25, 40, 2);
    	dc.fillCircle(owlPositionX + 50, 40, 2);
	}
	
	function drawFace(dc, faceColor, owlPositionX)
	{
		dc.setColor(faceColor, Gfx.COLOR_TRANSPARENT);
    	dc.fillCircle(owlPositionX + 75/2, 33, 25);
	}
	
	function drawEyeContour(dc, eyeContourColor, owlPositionX)
	{
		dc.setColor(eyeContourColor, Gfx.COLOR_TRANSPARENT);
		dc.fillCircle(owlPositionX + 25, 40, 4);
    	dc.fillCircle(owlPositionX + 50, 40, 4);
	}
	
	function drawEyesInPosition(dc, eyesClosed, eyeColor, eyeContourColor, faceColor, owlPositionX)
	{
		drawFace(dc, faceColor, owlPositionX);
		drawEyeContour(dc, eyeContourColor, owlPositionX);
		drawWideEyes(dc, faceColor, owlPositionX);
 		
    	if (eyesClosed == 0)
    	{
			drawWideEyes(dc, eyeColor, owlPositionX);
    	}
    	else
    	{
    		drawShutEyes(dc, owlPositionX, faceColor);    	
    	}
	}
}