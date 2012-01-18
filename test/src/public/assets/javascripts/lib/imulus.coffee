@module "Imulus", ->
  
  @VERSION = '0.1.0'
  
  @elementSupportsAttribute = (element, attribute)->
    attribute of document.createElement element

