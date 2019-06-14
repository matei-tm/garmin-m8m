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

    function drawCameo(dc, backColor, x, y)
    {
        dc.setColor(backColor, Gfx.COLOR_TRANSPARENT);
        dc.fillEllipse(x, y, 5, 7);
    }

    function drawIconByConnectedState(dc, color, backColor, alertColor, isConnected, owlPositionX){
        var x = owlPositionX + 38 + 7;
        var y = 73;

        drawCameo(dc, backColor, x, y);

        if (isConnected)
        {
            drawIcon(dc,x,y,color);
        }
        else
        {
            drawIcon(dc,x,y,alertColor);
        }
    }
}