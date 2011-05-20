COYOTE
=============

An intelligent command-line tool for combining and compressing JavaScript files.

Coyote selectively concatenates your JS files, combining them into a single file with the option of running the output through the Google Closure Compiler before save. Coyote automatically observes your directories and source files for changes and will recompile and save on the fly for easy development.


Installation
------
	$ gem install coyote

Usage
------

**Configuration**

	$ cd myproject/scripts
	$ coyote generate

*This will create the configuration file at coyote.yaml and will find any .js files and automatically add them to the input parameter. Open coyote.yaml and modify the input and output configurations to meet your needs. Coyote will combine the input files in the order you define.*

**Running Coyote**

	$ coyote

**Building without watching**

	$ coyote build

**Wildcarding input**
You can wildcard your input parameters to find files.

	- **/*.js # recursively find all files with the extension '.js'
	- /jquery/plugins/*.js # find all .js files in the directory
	

**Dependency discovery**
If your JavaScript files depend on other files or libraries to run, you can define those dependencies so Coyote will include them in the compiled output before the files that require them.

	// require /jquery/jquery.js
	
or simply

	// require jquery

Dependencies are relative to the top level of your directory, likely where your coyote.yaml config file is located.


Options
-------
**Forced compression**

	$ coyote -c

or

	$ coyote build -c

Plan
----

- Global configuration for logging
- Support for Growl notifications
- Configuration options for level of compression


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