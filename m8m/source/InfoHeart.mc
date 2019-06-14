using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Activity as Activity;
using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class InfoHeart extends Ui.Drawable {
    private var mLeft;
    private var mRight;
    private var mTop;
    private var mBottom;
    private var owlPositionX;

    function initialize(params) {

        Drawable.initialize(params);

        mLeft = params[:left];
        mRight = params[:right];
        mTop = params[:top];
        mBottom = params[:bottom];


        //onSettingsChanged();
    }

    function draw(dc) {
        var owlView = App.getApp().getView().findDrawableById("LogoImage");
        owlPositionX = owlView.locX;
        update(dc, false);
    }

    function update(dc, isPartialUpdate) {
        if (isPartialUpdate) {
            return;
        }

        drawStatus(dc);
    }

    function drawRate(dc,x,y,max){
        var startRate = 60;
        var size = 2;
        var width = 3;

        dc.setPenWidth(width);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);

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

        dc.drawLine(0, 0, 250, 150);
        for (var i=0; i<= max/10-6; i++)
        {
            dc.drawArc(x, y, size + 5*i,    0, angleArrayLeftWing[i][0],  angleArrayLeftWing[i][1]);

            if (i > 6) {dc.drawArc(x+68, y+5, size + 5*i,    0, angleArrayRightWing[i][0], angleArrayRightWing[i][1]);}
        }
    }

    function drawStatus(dc){
        var x = owlPositionX;
        var y = 120;
        var value = 0;

        try {

            var activityInfo = Activity.getActivityInfo();
            var sample = activityInfo.currentHeartRate;

            if (sample != null) {
                value = sample;
            }
            else if (ActivityMonitor has :getHeartRateHistory) {
                sample = ActivityMonitor.getHeartRateHistory(1,  true).next();

                if ((sample != null) && (sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE)) {
                    value = sample.heartRate;
                }
            }

            drawRate(dc,x,y, value);
            System.println(value.toString());
        } catch (e instanceof Lang.Exception) {
            System.println(e.getErrorMessage());
        }

        return value;
    }
}