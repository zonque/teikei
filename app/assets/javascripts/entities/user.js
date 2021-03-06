Teikei.module('Entities', function(Entities, Teikei, Backbone, Marionette, $, _) {

  Entities.User = Backbone.Model.extend({

    initialize: function() {
      if (this.tokenIsPresent()) {
        this.setUpHeader();
        this.loadSessionFromCookie();
      }
    },

    signIn: function(signInData, callback) {
      // clear data that may exist from a former sign up:
      this.clear({silent: true});

      return this.save(signInData, {
        url: "/users/sign_in",
        success: callback.success,
        error: callback.error
      });
    },

    urlRoot: function() {
      return "/api/v1/users/";
    },

    parse: function(data) {
      // Sign in: The `data` contains both a `user`-object and a `auth_token`.
      if ('user' in data && 'auth_token' in data) {
        this.setSessionInCookie(data.user.id, data.user.name, data.user.email, data.user.phone, data.auth_token);
        this.setUpHeader();
        return data.user;
      }

      // Sign up: The `data` contains only the properties of the `user`-object.
      return data;
    },

    defaults: {
      name: "",
      phone: "",
      email: "",
    },

    tokenIsPresent: function() {
      return $.cookie("auth_token") !== undefined;
    },

    signUp: function(signUpData, callback) {
      return this.save(signUpData, {
        url: "/api/v1/users",
        success: callback.success,
        error: callback.error
      });
    },

    signOut: function(callback) {
      return this.destroy({
        url: "/users/sign_out",
        success: callback.success,
        error: callback.error
      });
    },

    destroy: function() {
      this.unsetSessionInCookie();
      return Backbone.Model.prototype.destroy.apply(this, arguments);
    },

    setSessionInCookie: function(userId, userName, email, phone, authToken) {
      $.cookie("user_id", userId);
      $.cookie("user_name", userName);
      // $.cookie("email", email);
      // $.cookie("phone", phone);
      $.cookie("auth_token", authToken);
    },

    unsetSessionInCookie: function() {
      $.removeCookie("user_id");
      $.removeCookie("user_name");
      // $.removeCookie("email");
      // $.removeCookie("phone");
      $.removeCookie("auth_token");
    },

    loadSessionFromCookie: function() {
      this.set("id", $.cookie('user_id', Number));
      this.set("name", $.cookie('user_name'));
      this.fetch();
      // this.set("email", $.cookie('email'));
      // this.set("phone", $.cookie('phone'));
    },

    setUpHeader: function() {
      var authToken = $.cookie("auth_token");
      if (authToken === undefined) {
        throw "The cookie is undefined. Invoke `setAuthTokenInCookie` before.";
      }
      var headerData = { auth_token: authToken };
      $.ajaxSetup({ headers: headerData });
    },

    resetHeader: function() {
      // TODO Remove the auth_token onSignOut.
    }

  });
});
