using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;
using Toybox.Application as App;
using Toybox.Activity as Activity;
using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.WatchUi as Ui;

class OwlShapes extends Ui.Drawable {
    var x = 93;
    var y = 39;
    var w = 10;
    var h = 4;
    var offset = 1;
    var penWidth = 1;
    hidden var owlShape;
    private var owlPositionX;
    var eyeColor;
    var eyeContourColor;
    var faceColor;

    function initialize(params) {

        Drawable.initialize(params);
        owlShape = Ui.loadResource(Rez.Drawables.LogoImageOwl);

        onSettingsChanged();
    }

    function onSettingsChanged(){
        eyeContourColor = App.getApp().getProperty("OwlForegroundColor");
        faceColor = App.getApp().getProperty("OwlBackgroundColor");
        eyeColor = App.getApp().getProperty("OwlAlertColor");
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

        var stepsDone = ActivityMonitor.getInfo().steps.toFloat();
        var stepsTarget = ActivityMonitor.getInfo().stepGoal;
        var stepsPerDeca = stepsDone / stepsTarget * 10;

        var minutesRange = Sys.getClockTime().min % 10;

        var eyesAreClosed = minutesRange > stepsPerDeca;

        drawEyesInPosition(dc, eyesAreClosed, eyeColor, eyeContourColor, faceColor, owlPositionX);
        dc.drawBitmap(owlPositionX,5,owlShape);

    }


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