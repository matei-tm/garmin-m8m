using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Activity as Activity;
using Toybox.ActivityMonitor as ActivityMonitor;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

enum {
  DECORATIVE_ON_WINGS = 0,
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

    showActiveWings = App.getApp().getProperty("ShowActiveWings");
    showOnWings = App.getApp().getProperty("ShowOnWings");
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

  function drawWings(dc, x, y, max) {
    var startRate = 60;
    var size = 2;
    var width = 3;

    dc.setPenWidth(width);


    var angleArrayLeftWing = [
      [65, 85], //60
      [65, 85], //70
      [65, 85], //80
      [65, 85], //90
      [65, 88], //100
      [65, 90], //110
      [65, 90], //120
      [65, 90], //130
      [62, 90], //140
      [60, 90], //150
      [60, 89], //160
      [60, 88], //170
      [60, 85] //180
    ];

    var angleArrayRightWing = [
      [0, 0], //60
      [0, 0], //70
      [0, 0], //80
      [0, 0], //90
      [0, 0], //100
      [0, 0], //110
      [0, 0], //120
      [90, 92], //130
      [90, 92], //140
      [90, 94], //150
      [91, 95], //160
      [91, 96], //170
      [91, 97] //180
    ];

    for (var i = 0; i <= 12; i++) {
      if (i <= max / 10 - 6) {
        dc.setColor(owlAlertColor, Gfx.COLOR_TRANSPARENT);
      } else {
        dc.setColor(owlForegroundColor, Gfx.COLOR_TRANSPARENT);
      }

      dc.drawArc(x, y, size + 5 * i, 0, angleArrayLeftWing[i][0], angleArrayLeftWing[i][1]);

      if (i > 6) {
        dc.drawArc(x + 68, y + 5, size + 5 * i, 0, angleArrayRightWing[i][0], angleArrayRightWing[i][1]);
      }
    }
  }

  function drawStatus(dc) {
    var x = owlPositionX;
    var y = 120;

    try {
      var value = 0;
      switch (showOnWings) {
        case DECORATIVE_ON_WINGS:
          value = 0;
          break;
        case FLOORS_ON_WINGS:
          value = getFloorsPercentValue();
          break;
        case HEARTRATE_ON_WINGS:
          value = getHeartRateValue();
          break;
      }

      drawWings(dc, x, y, value);
    } catch (e instanceof Lang.Exception) {
      System.println(e.getErrorMessage());
    }
  }

  function getHeartRateValue() {
    // we will handle values from 0 to 200
    var value = 0;
    var activityInfo = Activity.getActivityInfo();
    var sample = activityInfo.currentHeartRate;

    if (sample != null) {
      value = sample;
    } else if (ActivityMonitor has: getHeartRateHistory) {
      sample = ActivityMonitor.getHeartRateHistory(1, true).next();

      if ((sample != null) && (sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE)) {
        value = sample.heartRate;
      }
    }

    return value;
  }

  function getFloorsPercentValue() {
    var value = 0;
    var sample;

    if (ActivityMonitor has: getInfo) {
      sample = ActivityMonitor.getInfo();

      if ((sample != null) && (sample.floorsClimbedGoal > 0)) {
        value = sample.floorsClimbed / sample.floorsClimbedGoal * 100;
      }
    }
System.println(value);
    return value;
  }
}