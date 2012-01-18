@module "Imulus", ->
  @module "Maps", ->
    class @InfoWindow
      
      # Class variable
      @windows: []

      constructor : (@map, @marker, params)->
        Imulus.Maps.InfoWindow.windows.push this
        {@title, @body} = params
        do @build

      settings : {}

      build : ->
        content = "<div class='infowindow-content'>"
        if @title then content += "<div class='title'>#{@title}</div>"
        if @body then content += "<div class='body'>#{@body}</div>"
        content += "</div>";
    
        @settings.content = content
    
        @window = new google.maps.InfoWindow @settings


      open : -> 
        do @closeAll
        @window.open @map.canvas, @marker


      close : -> 
        @window.close()


      closeAll : ->
        _window.close() for _window in Imulus.Maps.InfoWindow.windows

