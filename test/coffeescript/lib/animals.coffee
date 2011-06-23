class Animal
  constructor: (@name) ->

  move: (meters) ->
    console.log @name + " moved " + meters + "m."


class Horse extends Animal
  move: ->
    console.log "Galloping..."
    super 45
    



class Snake extends Animal
  move: ->
    console.log "Slithering..."
    super 5



sam = new Snake "Sammy the Python"
tom = new Horse "Tommy the Palomino"

sam.move()
tom.move()


