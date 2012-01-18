@module "Imulus", ->
  @module "Maps", ->
    class @Results

      constructor: (@$table, @data)->
        @$head  = @$table.find('thead')
        @$body  = @$table.find('tbody')
        @$foot  = @$table.find('tfoot')
        @$prev  = null
        @$next  = null
        @proto  = []
        @limit  = 25
        @total  = 0
        @sets   = []
        @active_set = 0
        @paginated = false
        do @build

      build: ->
        # Build the <thead>
        col = 0
        $row = $('<tr />')
        for column in @data.table
          @proto.push column.Key
          col++
          $cell = $('<th />').attr('class', "col-#{col}").html(column.Value)
          $row.append($cell)
        @$head.append $row
    
        # Build the <tfoot>
        $row = $('<tr />')
        for num in [1..@proto.length]
          value = ""
          if num is 1
            @$prev = $("<a />").attr({"href": "#", "class": "prev"}).html("&laquo; Previous").hide()
            value = @$prev
          if num is @proto.length
            @$next = $("<a />").attr({"href": "#", "class": "next"}).html("Next &raquo;").hide()
            value = @$next
          $cell = $('<td />').html value
          $row.append($cell)
        @$foot.append $row


      reset: ->
        @$body.empty()
        @total = 0
        @sets  = []
        @active_set = 0
        @$foot.hide()

      add: (node)->
        @total++
        index = @sets.length - 1
    
        if @total % @limit is 1
          index = index + 1
        if @total <= @limit
          index = 0
      
        @sets[index] = [] if not @sets[index]?
        @sets[index].push node

        if @total is @limit then @loadSet(0)
        if @total > @limit and not @paginated then @paginate()


      paginate: ->
        @paginated = true

        @$foot.show()

        @$prev.show().click (event) =>
          event.preventDefault()
          if @active_set > 0
            new_set_index = @active_set - 1
          else
            new_set_index = @sets.length - 1
          @loadSet new_set_index

        @$next.show().click (event) =>
          event.preventDefault()
          if @active_set < @sets.length - 1
            new_set_index = @active_set + 1
          else
            new_set_index = 0
          @loadSet new_set_index

      observe : (action, callback) ->
        @$body.find('tr').live action, ->
          id = $(this).attr 'data-marker-id'
          callback id
      

      loadSet: (index) ->
        @$body.empty()      
        @active_set = index
        @addRow node for node in @sets[@active_set]      


      addRow: (node)->
        $row = $('<tr />').attr 'data-marker-id', node.id

        for column in @proto
          for property in node.customProperties
            if property.Key is column
              $row.append $('<td />').html property.Value

        @$body.append $row
    

      none: (text)->
        if text
          $row = $('<tr />')
          $row.append $('<td />').html text
          @$body.append $row    
    
