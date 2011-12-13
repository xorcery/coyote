@module "ClientName", ->

  class @Interface
    constructor: ->
      do @build

    build: ->
      new Keystone.Forms
