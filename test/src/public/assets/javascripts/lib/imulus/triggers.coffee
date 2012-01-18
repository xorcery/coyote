@module "Imulus", ->
  class @Triggers
    constructor: ($form)->
      do @build

    build: ->
      $('.trigger').each ->
        $trigger  = $(this)
        href      = $trigger.attr('href')
        $remote   = $(href)

        if $remote.is(':visible') or $remote.hasClass('active')
          $trigger.addClass('active')

        $trigger.click (event) ->
          event.preventDefault()
          if $trigger.hasClass 'active'
            $remote.removeClass('active').slideUp 500, ->
              $("[class*='trigger'][href='#{href}']").removeClass 'active'
          else
            $remote.addClass('active').slideDown 500
            $("[class*='trigger'][href='#{href}']").addClass 'active'
      



