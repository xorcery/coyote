@module "Keystone", ->
  class @Forms

    constructor: ($form) ->
      do @build

    build: ->
      if not Keystone.elementSupportsAttribute 'input', 'placeholder'
        $('input[placeholder]').each ->
          $input = $(this)
          placeholder = $input.attr 'placeholder'
          $input.val(placeholder).addClass 'inactive'
          $input.bind
            focus : ->
              if $input.val() is placeholder
                $input.val('').removeClass 'inactive'
            blur : ->
              if $input.val() is ''
                $input.val(placeholder).addClass 'inactive'
