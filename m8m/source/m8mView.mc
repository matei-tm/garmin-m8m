using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor as Act;

class m8mView extends Ui.WatchFace {
	
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    
		showTimeLabel();
		showLogoLabel();
		showBattery(dc);
        showDate();
        showSteps();
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        updateBatteryLevel(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }
    
    function showSteps() {   
    	var activityInfo = Act.getInfo();
    	var dataString = activityInfo.steps.toString();

    	setForegroundColorAndContentOnDrawable("StepsLabel", dataString);
    }
    
    function showBattery(dc) {
    	var dataString = (System.getSystemStats().battery + 0.5).toNumber().toString() + "%";
    	
    	
		setForegroundColorAndContentOnDrawable("BatteryLabel", dataString);
    }
    
    function showDate() {
		var info = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateString = Lang.format("$1$ $2$ $3$", [info.day_of_week, info.month, info.day]);

        // Update the view
        setForegroundColorAndContentOnDrawable("DateLabel", dateString);
    }

	function showLogoLabel() {
		var logoString = App.getApp().getProperty("LogoString");
		setForegroundColorAndContentOnDrawable("LogoLabel", logoString);
 	}
	
	function showTimeLabel() {
	    // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = Sys.getClockTime();
        var hours = clockTime.hour;
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (App.getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        setForegroundColorAndContentOnDrawable("TimeLabel", timeString);
	}
	
	function setForegroundColorAndContentOnDrawable(drawableId, content)
	{
	    var view = View.findDrawableById(drawableId);
        view.setColor(App.getApp().getProperty("ForegroundColor"));
        view.setText(content);   
	}	

	function updateBatteryLevel(dc) {
        var batteryLevel = System.getSystemStats().battery;
        var x = 93;
        var y = 39;
        var w = 10;
        var h = 4;
		
		if (batteryLevel > 20)
		{
			dc.setColor(App.getApp().getProperty("ForegroundColor"), Gfx.COLOR_TRANSPARENT);
		}
		else
		{
        	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        }
        
        dc.fillRectangle(x, y, batteryLevel/100*w, h);
    }
}
