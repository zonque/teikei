Teikei.module("User", function(User, Teikei, Backbone, Marionette, $, _) {

  User.MenuView = Marionette.ItemView.extend({

    el: "#user-menu",

    template: "user/menu",

    ui: {
      signIn: "#signin",
      signOut: "#signout",
      userName: "#user-name",
      participateMenuItem: "#participate",
      myEntriesMenuItem: "#my-entries",
      newEntryMenuItem: "#new-entry",
      newEntryDropdown: "#new-entry .dropdown",
      userDropdown: ".account-menu .dropdown"
    },

    events: {
      "click #new-entry": "openNewEntryDropdown",
      "click #user-name": "openUserDropdown",
      "click #signup": "onSignUp",
      "click #add-farm": "addFarm",
      "click #add-depot": "addDepot",
      "click #my-entries": "showEntryList",
      "click #participate": "onParticipate"
    },

    triggers: {
      "click #signin": "signin:selected",
      "click #signout": "logout:selected"
    },

    initialize: function() {
      this.bindUIElements();
      this.invalidate();
      Teikei.vent.on("user:signin:success", this.invalidate, this);
      Teikei.vent.on("user:logout:success", this.invalidate, this);
    },

    invalidate: function() {
      var signedIn = this.model.tokenIsPresent();
      if (signedIn) {
        var userName = this.model.get("name");
        this.renderSignedInState(userName);
      }
      else {
        this.renderSignedOutState();
      }
    },

    openNewEntryDropdown: function() {
      this.openDropdown(this.ui.newEntryDropdown);
    },

    // TODO Merge function with duplicate in entryList.js
    openDropdown: function(dropdown) {
      dropdown.show();
      _.defer( function() {
        $("body").one("click", function() {
          dropdown.hide();
        });
      });
    },

    addFarm: function(event) {
      event.preventDefault();
      Teikei.vent.trigger("user:add:farm");
    },

    addDepot: function(event) {
      event.preventDefault();
      Teikei.vent.trigger("user:add:depot");
    },

    showEntryList: function(event) {
      event.preventDefault();
      Teikei.vent.trigger("user:show:entrylist");
    },

    onParticipate: function(event) {
      event.preventDefault();
      Teikei.vent.trigger("show:participate:1");
    },

    onSignUp: function(event) {
      event.preventDefault();
      this.trigger("signup:selected");
    },

    renderSignedInState: function(userName) {
      this.render();
      this.ui.signIn.hide();
      this.ui.participateMenuItem.hide();
      this.ui.userName.show();
      this.ui.newEntryMenuItem.show();
      this.ui.myEntriesMenuItem.show();
    },

    renderSignedOutState: function() {
      this.render();
      this.ui.signIn.show();
      this.ui.participateMenuItem.show();
      this.ui.userName.hide();
      this.ui.newEntryMenuItem.hide();
      this.ui.myEntriesMenuItem.hide();
      this.ui.userDropdown.hide();
    }

  });
});
