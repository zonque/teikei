Teikei.module("Places", function(Places, Teikei, Backbone, Marionette, $, _) {

  var DEFAULT_ZOOM = 10;
  var MIN_ZOOM = 6;
  var MAX_ZOOM = 12;

  Places.MapView = Marionette.ItemView.extend({

    element: "#map",

    markers: [],

    initialize: function(options) {
      this.defaultBounds = options.defaultBounds;
      this.collection.once("reset", this.initMap, this);
      this.collection.bind("change", this.updateMap, this);
      this.collection.bind("add", this.add, this);
    },

    showTip: function(id) {
      var marker = _.find(this.markers, function(item){
        return Number(id) === item.model.id;
      });
      this.initTip(marker);
      marker.openPopup();
    },

    initTip: function(marker) {
      if (marker === undefined) {
        return;
      }
      var model = marker.model;
      var mapItemView = new Places.MapItemView({model: model});
      mapItemView.render();
      marker.bindPopup(mapItemView.el, {offset: L.point(0, -55)});

      this.listenTo(mapItemView, "select:details", function(){
        this.trigger("select:details", model.id, model.get("type"));
      }, this);

      this.listenTo(mapItemView, "select:network", function(){
        this.trigger("select:network", model.id, model.get("type"));
      }, this);
    },

    add: function(model) {
      this.updateMap();
      this.map.setView(this.getLatLng(model), DEFAULT_ZOOM);
      this.showTip(model.id);
    },

    updateMap: function(model) {
      this.markerLayer.clearLayers();
      this.markerLayer = this.initMarkerLayer(this.collection);
      this.map.addLayer(this.markerLayer);
    },

    hilightMarkers: function(places) {
      var bounds = [];
      _.each(this.markers, function(marker) {
        marker.setOpacity(0.3);
        _.each(places, function(place){
          if (place.id === marker.model.id) {
            marker.setOpacity(1);
            bounds.push(marker.getLatLng());
          }
        });
      });
      this.map.fitBounds(bounds);
    },

    drawNetwork: function(places) {
      var networkLayer = this.networkLayer;
      var farms = _.filter(places, function(item) {
        return item.type === "Farm";
      });
      var depots = _.filter(places, function(item) {
        return item.type === "Depot";
      });

      _.each(farms, function(farm) {
        _.each(depots, function(depot) {
          var latlngs = [
            new L.LatLng(farm.latitude, farm.longitude),
            new L.LatLng(depot.latitude, depot.longitude)
          ];
          var polyline = L.polyline(latlngs, {color: '#a00e46', weight: 2});
          polyline.addTo(networkLayer);
        });
      });
    },

    hilightNetwork: function(model) {
      var places = _.map(model.get("places"), function(item) {
        return item.place;
      });
      places.push(model.attributes);
      this.drawNetwork(places);
      this.hilightMarkers(places);
    },

    unHilightNetwork: function() {
      _.each(this.markers, function(marker) {
        _.defer(function(){
          marker.setOpacity(1);
        });
      });
      this.networkLayer.clearLayers();
      Backbone.history.navigate('/');
    },

    showArea: function(bounds) {
      this.map.fitBounds(bounds);
    },

    initMap: function() {
      this.tileLayer = this.initTileLayer();
      this.networkLayer = L.layerGroup();
      this.markerLayer = this.initMarkerLayer(this.collection);
      this.map = L.map("map", {
        attributionControl: false,
        maxZoom: MAX_ZOOM,
        minZoom: MIN_ZOOM
      });
      this.map.fitBounds(this.defaultBounds);
      this.map.addLayer(this.tileLayer);
      this.map.addLayer(this.networkLayer);
      this.map.addLayer(this.markerLayer);
      this.map.addControl(this.initFooter());
      this.map.on("popupclose", _.bind(this.unHilightNetwork, this));
    },

    initMarkerLayer: function(collection) {
      var markers = this.markers = [];
      collection.each(function(model){
        var marker = this.initMarker(model);
        if (marker) markers.push(marker);
      }, this);
      return L.layerGroup(markers);
    },

    initMarker: function(model) {
      var type = model.get("type");
      var icon = new Places.MarkerIcon[type]();
      var location = this.getLatLng(model);

      if (location) {
        var marker = L.marker(location, {icon: icon});
        marker.model = model;
        this.initTip(marker);
        marker.on("popupopen", _.bind(function () {
          Backbone.history.navigate('places/' + model.id + '/tip');
        }, this));
        marker.on("popupclose", _.bind(function () {
          Backbone.history.navigate('');
        }, this));
        return marker;
      }
    },

    getLatLng: function(model){
      var lat = model.get("latitude");
      var lng = model.get("longitude");
      if (lat && lng) {
        return new L.LatLng(lat, lng);
      }
    },

    initTileLayer: function() {
      return L.tileLayer("//{s}.tiles.mapbox.com/v3/" + Places.MapConfig.APIKEY + "/{z}/{x}/{y}.png")
      // return L.tileLayer("//{s}.tiles.mapbox.com/v3/" + Places.MapConfig.APIKEY + "/{z}/{x}/{y}.png", {
      //   attribution: this.initFooter()
      // })
    },

    initFooter: function() {
      var template = JST["places/footer"]()
      var footer = L.control.attribution({prefix: false})
      return footer.addAttribution(template)
    }
  });
});
