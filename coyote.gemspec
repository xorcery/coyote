# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{coyote}
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Imulus"]
  s.date = %q{2011-12-12}
  s.default_executable = %q{coyote}
  s.description = %q{An intelligent command-line tool for combining, compressing and compiling your JavaScript and CoffeeScript files.}
  s.email = %q{developer@imulus.com}
  s.executables = ["coyote"]
  s.extra_rdoc_files = ["README.md", "bin/coyote", "lib/coyote.rb", "lib/coyote/closure_compiler.rb", "lib/coyote/configuration.rb", "lib/coyote/fs_listener.rb", "lib/coyote/fs_listeners/darwin.rb", "lib/coyote/fs_listeners/linux.rb", "lib/coyote/fs_listeners/polling.rb", "lib/coyote/fs_listeners/windows.rb", "lib/coyote/generator.rb", "lib/coyote/notification.rb", "lib/coyote/script.rb", "lib/coyote/scripts/coffeescript.rb", "lib/coyote/scripts/combine.rb", "lib/coyote/scripts/javascript.rb"]
  s.files = ["README.md", "Rakefile", "bin/coyote", "config/coyote-icon.png", "config/coyote-usage.txt", "config/coyote.yaml", "coyote.gemspec", "lib/coyote.rb", "lib/coyote/closure_compiler.rb", "lib/coyote/configuration.rb", "lib/coyote/fs_listener.rb", "lib/coyote/fs_listeners/darwin.rb", "lib/coyote/fs_listeners/linux.rb", "lib/coyote/fs_listeners/polling.rb", "lib/coyote/fs_listeners/windows.rb", "lib/coyote/generator.rb", "lib/coyote/notification.rb", "lib/coyote/script.rb", "lib/coyote/scripts/coffeescript.rb", "lib/coyote/scripts/combine.rb", "lib/coyote/scripts/javascript.rb", "test/plugins/a_plugin.coffee", "test/plugins/a_plugin.js", "test/plugins/more_plugins/b_plugin.coffee", "test/plugins/more_plugins/even_more_plugins/c_plugin.coffee", "Manifest"]
  s.homepage = %q{http://github.com/imulus/coyote}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Coyote", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{coyote}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Coyote selectively concatenates your files, combining them into a single file with the option of running the output through the Google Closure Compiler before save. It can be used to observe your source files for changes and will recompile and save on the fly for easy development.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rb-fsevent>, [">= 0.4.0"])
      s.add_runtime_dependency(%q<rb-appscript>, [">= 0.6.1"])
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 1.0.5"])
      s.add_development_dependency(%q<rb-fsevent>, [">= 0.4.0"])
      s.add_development_dependency(%q<rb-appscript>, [">= 0.6.1"])
      s.add_development_dependency(%q<term-ansicolor>, [">= 1.0.5"])
    else
      s.add_dependency(%q<rb-fsevent>, [">= 0.4.0"])
      s.add_dependency(%q<rb-appscript>, [">= 0.6.1"])
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
      s.add_dependency(%q<rb-fsevent>, [">= 0.4.0"])
      s.add_dependency(%q<rb-appscript>, [">= 0.6.1"])
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
    end
  else
    s.add_dependency(%q<rb-fsevent>, [">= 0.4.0"])
    s.add_dependency(%q<rb-appscript>, [">= 0.6.1"])
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
    s.add_dependency(%q<rb-fsevent>, [">= 0.4.0"])
    s.add_dependency(%q<rb-appscript>, [">= 0.6.1"])
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
  end
end
