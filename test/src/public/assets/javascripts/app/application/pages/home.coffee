@module "Application.Pages", ->

  @home = ->    
    $('#slides').cycle({ 
      fx        : 'fade', 
      speed     : 1000, 
      timeout   : 5000,
      pager     : "#slides-nav"
    });
