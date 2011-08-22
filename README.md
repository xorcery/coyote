COYOTE
=============

An intelligent command-line tool for combining, compressing and compiling your JavaScript and CoffeeScript files.

Coyote selectively concatenates your files, combining them into a single file with the option of running the output through the Google Closure Compiler before save. It can be used to observe your source files for changes and will recompile and save on the fly for easy development.

Coyote automatically compiles CoffeeScript files (bare, with no safety closure) before combining them with other source files. You can freely combine JavaScript and CoffeeScript source files in your compilation.


Installation
------
	$ gem install coyote

Requirements
------
- Compiling CoffeeScript files requires that you have nodejs and coffee-script installed
- Growl notifications require that you have Growl installed

Terminal Usage
------

**Configuration**

	$ cd myproject/scripts
	$ coyote new

*This will create the configuration file (coyote.yaml) and will discover any .js and .coffee files in this directory, automatically adding them to the configuration. Open coyote.yaml and modify the input and output configurations to meet your needs. Coyote will combine the input files in the order you define.*

**Trigger a build**

	$ coyote build

**Trigger the observer**

	$ coyote watch

**Input wildcards**

You can wildcard your input parameters to find files.

	- **/*.js # recursively find all files with the extension '.js'
	- /jquery/plugins/*.js # find all .js files in the directory


**Dependency discovery**

If your files depend on other files or libraries to run, you can define those dependencies so Coyote will include them in the compiled output before the files that require them.

	//= require /jquery/jquery.js
	#= require /jquery/jquery.js (in CoffeeScript)

or simply

	//= require jquery
	#= require jquery (in CoffeeScript)

Dependencies are relative to the top level of your directory, likely where your coyote.yaml config file is located.


Options
-------
**Compress output with Google Closure Compiler**

	$ coyote build -c
	$ coyote build --compress

or

	$ coyote watch -c
	$ coyote watch --compress

License
-------

Copyright (C) 2011 by Imulus

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.