using Toybox.Graphics as Gfx;

module InfoBluetooth{
	function drawIcon(dc,x,y,color){
		var size = 3;
		var width = 1 ;

		dc.setPenWidth(1);
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);

    	dc.fillPolygon([[x-size,y-size], [x-size+width,y-size-width],[x+size+width,y+size-width],[x+size,y+size]]);
		dc.fillPolygon([[x+size,y+size],[x+size-width,y+size-width],[x-width+1,y+size*2-width],[x,y+size*2]]);
		dc.fillPolygon([[x+2,y+size*2-2],[x+2-width-1,y+size*2+width-2],[x+2-width-1,y-size*2-width+2],[x+2,y-size*2+2]]);
		dc.fillPolygon([[x,y-size*2],[x-width+1,y-size*2+width],[x+size-width,y-size+width],[x+size,y-size]]);
		dc.fillPolygon([[x+size,y-size],[x+size+width,y-size+width],[x-size+width,y+size+width],[x-size,y+size]]);
	}
	
	function drawIconByConnectedState(dc, color, isConnected){
        var x = 43;
        var y = 73;

		if (isConnected)
		{
			drawIcon(dc,x,y,color);
		}
		else
		{
        	drawIcon(dc,x,y,Gfx.COLOR_RED);
        }  
	}
}