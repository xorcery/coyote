@module "Application", ->
  
  class @Interface
    constructor: ->
      do @build

    build: ->
      new Imulus.Forms
      new Imulus.Tables
      new Imulus.Triggers