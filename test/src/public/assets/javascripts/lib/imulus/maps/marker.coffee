@module "Imulus", ->
  @module "Maps", ->
    class @Marker

      constructor: (@map, params)->
        @hidden = false
        {@id} = params
        @center = new Imulus.Maps.Point params.lat, params.lng
        @infoWindow = null
        @fill_color = params.fill_color or Marker::fill_color or '#F0F'
        @text_color = params.text_color or Marker::text_color or '#000'
        @index = params.index
        @letter = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'][@index] or ""

        shadow = new google.maps.MarkerImage 'http://chart.apis.google.com/chart?chst=d_map_pin_shadow',
          new google.maps.Size(40, 37), new google.maps.Point(0,0), new google.maps.Point(0, 37)

        @marker = new google.maps.Marker
          position  : @center.latLng
          map       : @map.canvas
          shadow    : shadow

        @setColor @fill_color
        @setInfoWindow params.infoWindow if params.infoWindow
        do @show
        do @observe


      observe : ->
        if @infoWindow isnt null
          google.maps.event.addListener @marker, 'click', =>
            @infoWindow.open @marker

      show : ->
        @marker.setMap @map.canvas
        @hidden = false


      hide : ->
        @marker.setMap null
        @infoWindow.closeAll() if @infoWindow?
        @hidden = true





      setColor : (color)->
        @fill_color  = color
        @image_url = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=#{@letter}|#{@fill_color.substring(1)}|#{@text_color.substring(1)}"
        width   = 21
        height  = 34

        icon = new google.maps.MarkerImage(@image_url,
             new google.maps.Size(width, height),
             new google.maps.Point(0,0),
             new google.maps.Point(0, height))

        @marker.setOptions icon: icon


      setInfoWindow : (params)->
        @infoWindow = new Imulus.Maps.InfoWindow @map, @marker, params
        do @observe


