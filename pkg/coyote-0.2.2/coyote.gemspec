# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{coyote}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Casey O'Hara"]
  s.date = %q{2011-04-30}
  s.description = %q{A command-line tool for combining and compressing JS files}
  s.email = %q{casey.ohara@imulus.com}
  s.executables = ["coyote"]
  s.extra_rdoc_files = ["bin/coyote", "lib/coyote.rb", "lib/coyote/builder.rb", "lib/coyote/generator.rb", "lib/coyote/output.rb"]
  s.files = ["Manifest", "Rakefile", "bin/coyote", "config/coyote.yaml", "lib/coyote.rb", "lib/coyote/builder.rb", "lib/coyote/generator.rb", "lib/coyote/output.rb", "coyote.gemspec"]
  s.homepage = %q{http://github.com/caseyohara/coyote}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Coyote"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{coyote}
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Coyote is a command-line tool for combining and compressing JS files. It uses YAML for configuration and the Google Closure Compiler to compilation and compression.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<closure-compiler>, [">= 1.1.1"])
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 1.0.5"])
      s.add_development_dependency(%q<closure-compiler>, [">= 1.1.1"])
      s.add_development_dependency(%q<term-ansicolor>, [">= 1.0.5"])
    else
      s.add_dependency(%q<closure-compiler>, [">= 1.1.1"])
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
      s.add_dependency(%q<closure-compiler>, [">= 1.1.1"])
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
    end
  else
    s.add_dependency(%q<closure-compiler>, [">= 1.1.1"])
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
    s.add_dependency(%q<closure-compiler>, [">= 1.1.1"])
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.5"])
  end
end
