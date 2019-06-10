using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.ActivityMonitor as Act;

module InfoHeart{
	function drawRate(dc,x,y,color, max){
		var startRate = 60;
		var size = 2;
		var width = 3;

		dc.setPenWidth(width);
		dc.setColor(color, Gfx.COLOR_TRANSPARENT);
		
		var angleArray = [
			[65, 85],//60
			[65, 85],//70
			[65, 85],//80
			[65, 85],//90
			[65, 85],//100
			[65, 85],//110
			[65, 85],//120
			[65, 85],//130
			[65, 85],//140
			[65, 85],//150
			[65, 85],//160
			[65, 85],//170
			[65, 85]//180
		];

		for (var i=0; i<= max/10-6; i++)
		{
			dc.drawArc(x, y, size + 5*i,    0, angleArray[i][0], angleArray[i][1]);
			Sys.println("Rate counter: " + i);   
		}
 	}
	
	function drawStatus(dc, foregroundColor, backgroundColor, alertColor, owlPositionX){
        var x = owlPositionX;
        var y = 120;
        try {
			var hrIterator = Act.getHeartRateHistory(1, true);
			var lastSampleTime = null;
			
	
		    var sample = hrIterator.next();
		    if (null != sample) {
		        if (sample.heartRate != Act.INVALID_HR_SAMPLE) {
		                lastSampleTime = sample.when;
		                Sys.println("Sample: " + sample.heartRate);  
		                drawRate(dc,x,y,alertColor, sample.heartRate);    // print the current sample
		        }			
			}
		} catch (e instanceof Lang.Exception) {
    		System.println(e.getErrorMessage());
		} 
	}
}