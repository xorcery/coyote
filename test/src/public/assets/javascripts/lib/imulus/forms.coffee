@module "Imulus", ->
  class @Forms
    constructor: ($form)->
      do @build

    build: ->
      if not Imulus.elementSupportsAttribute 'input', 'placeholder'
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



      $('fieldset.overlay .row').each ->

        $label = $(this).find 'label'
        $input = $(this).find 'input'

        if $input.val() isnt "" 
          $label.hide()

        $label.click -> $input.focus()

        $input.bind
          focus: ->
            if $input.val() is ""
              $label.addClass 'faded'

          blur: ->
            if $input.val() is ""
              $label.fadeIn().removeClass 'faded'

          change: ->
            if $input.val() isnt ""
              $label.fadeOut().removeClass 'faded'

          keypress: ->
            $label.hide().removeClass 'faded'
