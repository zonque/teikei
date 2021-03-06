Teikei.module("Alert", function(Alert, Teikei, Backbone, Marionette, $, _) {
  Alert.Controller = {
    status: function(message, fadeOut) {
      this._sendFlashMessage({
        message: message,
        fadeOut: Teikei.Util.valueOrDefault(fadeOut, true),
        type: ''
      });
    },

    error: function(message, fadeOut) {
      this._sendFlashMessage({
        message: message,
        fadeOut: Teikei.Util.valueOrDefault(fadeOut, true),
        type: 'alert'
      });
    },

    success: function(message, fadeOut) {
      this._sendFlashMessage({
        message: message,
        fadeOut: Teikei.Util.valueOrDefault(fadeOut, true),
        type: 'success'
      });
    },

    _sendFlashMessage: function(alertData) {
      var model = new Backbone.Model(alertData);
      this.flashMessageView = new Teikei.Alert.FlashMessageView({model: model});
      Teikei.alertRegion.show(this.flashMessageView);
      if (alertData.fadeOut) {
        // fade out after 10 seconds
        setTimeout(function(){
          Teikei.alertRegion.close();
        }, 10000);
      }
    }
  }
});
