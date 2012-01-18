@module "Imulus", ->
  class @Tables
    constructor: ->
      do @build

    build: ->
      $('table').each -> 
        $('tr:even', $(this)).addClass 'even'
                
                
                