using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Activity as Act;


module InfoHeart{
	function drawRate(dc,x,y,color, max){
		var startRate = 60;
		var size = 2;
		var width = 3;

		dc.setPenWidth(width);
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		
		var angleArrayLeftWing = [
			[65, 85],//60
			[65, 85],//70
			[65, 85],//80
			[65, 85],//90
			[65, 88],//100
			[65, 90],//110
			[65, 90],//120
			[65, 90],//130
			[62, 90],//140
			[60, 90],//150
			[60, 89],//160
			[60, 88],//170
			[60, 85]//180
		];
		
		var angleArrayRightWing = [
			[0, 0],//60
			[0, 0],//70
			[0, 0],//80
			[0, 0],//90
			[0, 0],//100
			[0, 0],//110
			[0, 0],//120
			[90, 92],//130
			[90, 92],//140
			[90, 94],//150
			[91, 95],//160
			[91, 96],//170
			[91, 97]//180
		];

		for (var i=0; i<= max/10-6; i++)
		{
			dc.drawArc(x, y, size + 5*i,    0, angleArrayLeftWing[i][0],  angleArrayLeftWing[i][1]);
			if (i > 6) {dc.drawArc(x+68, y+5, size + 5*i,    0, angleArrayRightWing[i][0], angleArrayRightWing[i][1]);}
			Sys.println("Rate counter: " + i);   
		}
 	}
	
	function drawStatus(dc, foregroundColor, backgroundColor, alertColor, owlPositionX){
        var x = owlPositionX;
        var y = 120;
        
        try {
			var activityInfo = Act.getActivityInfo();	
			if (activityInfo has :currentHeartRate)
			{
			    if (null != activityInfo) {
			        if (activityInfo.currentHeartRate > 0) {
			                Sys.println("Current Heart Rate: " + activityInfo.currentHeartRate);  
			                drawRate(dc,x,y,alertColor, activityInfo.currentHeartRate);
			        }			
				}
			}
		} catch (e instanceof Lang.Exception) {
    		System.println(e.getErrorMessage());
		} 
	}
}