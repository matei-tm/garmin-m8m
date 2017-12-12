using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;

module InfoSteps{

	function drawBarStep(dc,steps,stepGoal,colorGoal){
		drawBarStepDetailed(
	        dc,
	        steps,
	        stepGoal,
	        20,
	        125,
	        115,
	        Gfx.COLOR_RED,
	        colorGoal,
	        4);
	}

	function drawBarStepDetailed(dc,steps,stepGoal,x,y,length,color,colorGoal,bar_width){
	    var steps_fraction = steps.toFloat()/stepGoal*length;
		var offset = 2;
		dc.setColor(colorGoal,Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(x,y,length,bar_width+offset);
	
		if(steps<stepGoal){
			dc.setColor(color,Gfx.COLOR_TRANSPARENT);
			dc.fillRectangle(x,y+offset,steps_fraction,bar_width);
       	}
       	else{
			dc.setColor(color,Gfx.COLOR_TRANSPARENT);
			dc.fillRectangle(x,y+offset,length,bar_width);
       	}
	}
}