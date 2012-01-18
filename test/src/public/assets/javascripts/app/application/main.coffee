@module "Application", ->

  @main = ->    
    new Application.Interface

    initializers = $('body').attr('data-js-init')
    
    Application.initializers = if initializers? then initializers.replace(" ","").split(",") else []
    
    for initializer in Application.initializers
      segments = initializer.split(".")
      method = window
      method = method[segment] for segment in segments
      do method if method?
