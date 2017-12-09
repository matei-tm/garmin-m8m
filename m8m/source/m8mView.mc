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
    	var view = View.findDrawableById("StepsLabel");
        view.setColor(App.getApp().getProperty("ForegroundColor"));
    
    	var activityInfo = Act.getInfo();
    	var dataString = activityInfo.steps.toString();

        view.setText(dataString); 
    }
    
    function showBattery(dc) {
		var viewBattery = View.findDrawableById("BatteryLabel");
        viewBattery.setColor(App.getApp().getProperty("ForegroundColor"));
    
    	var dataString = (System.getSystemStats().battery + 0.5).toNumber().toString() + "%";

        viewBattery.setText(dataString); 
    }
    
    function showDate() {
    // Get the current time and format it correctly
		var info = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$ $3$", [info.day_of_week, info.month, info.day]);

        // Update the view
        var view = View.findDrawableById("DateLabel");
        view.setColor(App.getApp().getProperty("ForegroundColor"));
        view.setText(dateStr);   
    }

	function showLogoLabel() {
        var viewLogoLabel = View.findDrawableById("LogoLabel");
        viewLogoLabel.setColor(App.getApp().getProperty("ForegroundColor"));
        switch (App.getApp().getProperty("LogoText"))
        {
        	case 1: viewLogoLabel.setText(Rez.Strings.M1); break;
        	case 2: viewLogoLabel.setText(Rez.Strings.M2); break;
        	case 3: viewLogoLabel.setText(Rez.Strings.M3); break;
        }
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

        // Update the view
        var view = View.findDrawableById("TimeLabel");
        view.setColor(App.getApp().getProperty("ForegroundColor"));
        view.setText(timeString);        
	}
}
