COYOTE
=============

##A speedy tool for combining and compressing your JavaScript, CoffeeScript, CSS and LESS source files.

Coyote combines your source files into a single script or stylesheet to reduce HTTP overhead and make development easier. It has built-in support for <a href="https://github.com/sstephenson/sprockets">Sprockets-style</a> dependency syntax (`#= require x`) and a lightning-fast, built-in watch mechanism to detect changes to your source files and recompile on the fly. For increased optimization, you can optionally run the final compilation through the Google Closure Compiler before save.




###Installation

		$ gem install coyote



###Command Line Interface

**Syntax:**

		$ coyote [input_filepath]:[output_filepath]

**Example**

		$ coyote src/application.coffee:build/application.min.js



###Options

<table>
	<thead>
		<th>Option</th>
		<th>Description</th>
	</thead>
	<tbody>
		<tr>
			<th>-c, --compress</th>
			<td>Compress the final compilation with the Google Closure Compiler</td>
		</tr>
		<tr>
			<th>-w, --watch</th>
			<td>Use the built-in watch mechanism to observe your source files and re-compile when something changes</td>
		</tr>
		<tr>
			<th>-q, --quiet</th>
			<td>Quiet the command-line output</td>
		</tr>
		<tr>
			<th>-v, --version</th>
			<td>Get the version of your Coyote gem</td>
		</tr>
	</tbody>
</table>            



###Requiring Source Files

Coyote has support for [Sprockets-style](https://github.com/sstephenson/sprockets) requires, with one exception. Instead of using `require_tree`, you can simply use `require` and Coyote will automatically detect if the path is a source file or a directory.


**Syntax:** (JavaScript)

		//= require other_file.js
		//= require some_directory

**Syntax:** (CoffeeScript)

		#= require other_file.coffee
		#= require some_directory

Paths used in `require` statements are evaluated relative to the file which contains them.


###Using with Rake

Coyote ships with convenience methods for neatly defining tasks in your Rakefile:


		require 'coyote/rake'

		coyote :build do |config|
		  config.input = "src/application.coffee"
		  config.output = "build/application.min.js"
		  config.options = { :compress => true }
		end 

		coyote :watch do |config|
		  config.input = "src/application.coffee"
		  config.output = "build/application.min.js"
		  config.options = { :quiet => true }
		end


This will create two Rake tasks, `build` and `watch`, which you can run as standard tasks: `rake build` and `rake watch`.


###Contribute
**We'd love your help. Fork us so we can make Coyote better.**

		$ git clone git://github.com/imulus/coyote


###Download

You can download this project in either
[zip](http://github.com/imulus/coyote/zipball/master) or [tar](http://github.com/imulus/coyote/tarball/master) formats.

or get the source code on GitHub : [imulus/coyote](http://github.com/imulus/coyote)



