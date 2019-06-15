using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Activity as Activity;
using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

enum {
  NOTHING = 0,
  DECORATIVE_ON_WINGS_01,
  DECORATIVE_ON_WINGS_02,
  FLOORS_ON_WINGS,
  HEARTRATE_ON_WINGS
}

class ActiveWings extends Ui.Drawable {
  private var mLeft;
  private var mRight;
  private var mTop;
  private var mBottom;
  private var owlPositionX;

  private var owlForegroundColor;
  private var owlBackgroundColor;
  private var owlAlertColor;
  private var showActiveWings;
  private var showOnWings;

  function initialize(params) {

    Drawable.initialize(params);

    mLeft = params[: left];
    mRight = params[: right];
    mTop = params[: top];
    mBottom = params[: bottom];

    onSettingsChanged();
  }

  function onSettingsChanged() {
    owlForegroundColor = App.getApp().getProperty("OwlForegroundColor");
    owlBackgroundColor = App.getApp().getProperty("OwlBackgroundColor");
    owlAlertColor = App.getApp().getProperty("OwlAlertColor");

    showOnWings = App.getApp().getProperty("ShowOnWings");
    showActiveWings = showOnWings != 0;
  }

  function draw(dc) {
    var owlView = App.getApp().getView().findDrawableById("LogoImage");
    owlPositionX = owlView.locX;
    update(dc, false);
  }

  function update(dc, isPartialUpdate) {
    if (isPartialUpdate || !showActiveWings) {
      return;
    }

    drawStatus(dc);
  }

  function drawWings(dc, x, y, fillingLevel, needDoubleFace) {
    System.println(fillingLevel);
    System.println(needDoubleFace);
    var startRadius = 3;
    var featherTraceWidth = 3;
    var featherGap = 6;

    dc.setPenWidth(featherTraceWidth);

    var angleArrayLeftWing = [
      [65, 85], //00-60
      [67, 85], //01-70
      [69, 85], //02-80
      [70, 85], //03-90
      [66, 88], //03-100
      [63, 90], //05-110
      [62, 90], //06-120
      [61, 89], //07-130
      [60, 89], //08-140
      [60, 88], //09-150
      [60, 87], //10-160
    ];

    var angleArrayRightWing = [
      [0, 0],   //00-60
      [0, 0],   //01-70
      [0, 0],   //02-80
      [0, 0],   //03-90
      [0, 0],   //04-100
      [0, 0],   //05-110
      [0, 0],   //06-120
      [90, 92], //07-130
      [90, 92], //08-140
      [90, 94], //09-150
      [91, 95], //10-160
    ];

    for (var i = 0; i <= 9; i++) {
      if (fillingLevel > 0 && i <= fillingLevel) {
        dc.setColor(owlAlertColor, Gfx.COLOR_TRANSPARENT);
      } else {

        if (needDoubleFace)
        {dc.setColor(owlBackgroundColor, Gfx.COLOR_TRANSPARENT);}
        else
        {dc.setColor(owlForegroundColor, Gfx.COLOR_TRANSPARENT);}
      }

      dc.drawArc(x, y, startRadius + featherGap * i, 0, angleArrayLeftWing[i][0], angleArrayLeftWing[i][1]);

      if (i > 6) {
        dc.drawArc(x + 68, y + 5, startRadius + featherGap * i, 0, angleArrayRightWing[i][0], angleArrayRightWing[i][1]);
      }
    }
  }

  function drawStatus(dc) {
    var x = owlPositionX;
    var y = 120;

    try {
      var value = 0;
      var needDoubleFace = false;
      switch (showOnWings) {
        case DECORATIVE_ON_WINGS_01:
          break;
        case DECORATIVE_ON_WINGS_02:
          needDoubleFace = true;
          break;
        case FLOORS_ON_WINGS:
          value = getFloorsPertenValue();
          break;
        case HEARTRATE_ON_WINGS:
          value = getHeartRateValue();
          if (value > 10) {
            value = value - 10 ;
            needDoubleFace = true;}
          break;
      }

      drawWings(dc, x, y, value, needDoubleFace);
    } catch (e instanceof Lang.Exception) {
      System.println(e.getErrorMessage());
    }
  }

  function getHeartRateValue() {

    var value = 0;
    var activityInfo = Activity.getActivityInfo();
    var sample = activityInfo.currentHeartRate;

    if (sample != null) {
      value = sample;
    } else if (ActivityMonitor has :getHeartRateHistory) {
      sample = ActivityMonitor.getHeartRateHistory(1, true).next();

      if ((sample != null) && (sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE)) {
        value = sample.heartRate;
      }
    }

    System.println(value);
    // value are from 0 to 200
    // we divide it by ten because  we expect values from 0 to 20;
    return value / 10; //
  }

  function getFloorsPertenValue() {
    var value = 0;
    var info;

    if (ActivityMonitor has :getInfo) {
      info = ActivityMonitor.getInfo();

      if ((info != null && info has :floorsClimbed) && (info.floorsClimbedGoal > 0)) {
        value = info.floorsClimbed / info.floorsClimbedGoal * 10;// a range from 0 to 10
      }
    }

    return value;
  }
}