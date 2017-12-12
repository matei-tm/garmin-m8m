using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;

module InfoBattery{
	var x = 93;
    var y = 39;
    var w = 10;
    var h = 4;
    var offset = 1;
    var penWidth = 1;

	function drawLevel(dc, batteryLevel, color) {
        
		
		if (batteryLevel > 20)
		{
			dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		}
		else
		{
        	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        }
        
        dc.fillRectangle(x, y, batteryLevel/100*w, h);
        drawBatteryShape(dc, batteryLevel, color);
    }
    
    function drawBatteryShape(dc, batteryLevel, color) {       
		
		if (batteryLevel > 20)
		{
			dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		}
		else
		{
        	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        }
        
        dc.setPenWidth(1);
        dc.drawRectangle(x-offset-penWidth, y-offset-penWidth, w+2*offset+2*penWidth, h+2*offset+2*penWidth);
        dc.drawLine(x+2*offset+w, y, x+2*offset+w, y+h);
    }
}