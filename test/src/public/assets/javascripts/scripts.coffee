#### VENDOR
#= require vendor/jquery.js
#= require jquery/**/*.js

#### LIBS
#= require lib/extensions.coffee
#= require lib/imulus.coffee
#= require imulus/forms.coffee
#= require imulus/tables.coffee

#### APP
#= require application/**/*.coffee

$ -> Application.main()
