using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class m8mApp extends App.AppBase {

    var mView;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        mView = new M8mView();
        return [ mView ];
    }

    function getView() {
        return mView;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
        mView.onSettingsChanged();
        Ui.requestUpdate();
    }

}