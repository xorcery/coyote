# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{coyote}
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Imulus}]
  s.date = %q{2011-10-03}
  s.description = %q{An intelligent command-line tool for combining, compressing and compiling your JavaScript and CoffeeScript files.}
  s.email = %q{developer@imulus.com}
  s.executables = [%q{coyote}]
  s.extra_rdoc_files = [%q{README.md}, %q{bin/coyote}, %q{lib/coyote.rb}, %q{lib/coyote/closure_compiler.rb}, %q{lib/coyote/configuration.rb}, %q{lib/coyote/coy_file.rb}, %q{lib/coyote/fs_listener.rb}, %q{lib/coyote/fs_listeners/darwin.rb}, %q{lib/coyote/fs_listeners/linux.rb}, %q{lib/coyote/fs_listeners/polling.rb}, %q{lib/coyote/fs_listeners/windows.rb}, %q{lib/coyote/generator.rb}, %q{lib/coyote/notification.rb}, %q{lib/coyote/output.rb}]
  s.files = [%q{README.md}, %q{Rakefile}, %q{bin/coyote}, %q{config/coyote-icon.png}, %q{config/coyote-usage.txt}, %q{config/coyote.yaml}, %q{coyote.gemspec}, %q{lib/coyote.rb}, %q{lib/coyote/closure_compiler.rb}, %q{lib/coyote/configuration.rb}, %q{lib/coyote/coy_file.rb}, %q{lib/coyote/fs_listener.rb}, %q{lib/coyote/fs_listeners/darwin.rb}, %q{lib/coyote/fs_listeners/linux.rb}, %q{lib/coyote/fs_listeners/polling.rb}, %q{lib/coyote/fs_listeners/windows.rb}, %q{lib/coyote/generator.rb}, %q{lib/coyote/notification.rb}, %q{lib/coyote/output.rb}, %q{Manifest}]
  s.homepage = %q{http://github.com/imulus/coyote}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Coyote}, %q{--main}, %q{README.md}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{coyote}
  s.rubygems_version = %q{1.8.5}
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
