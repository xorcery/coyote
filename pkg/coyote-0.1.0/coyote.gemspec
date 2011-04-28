# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{coyote}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Casey O'Hara"]
  s.date = %q{2011-04-28}
  s.description = %q{A command-line gem to combine multiple files}
  s.email = %q{casey.ohara@imulus.com}
  s.extra_rdoc_files = ["lib/coyote.rb"]
  s.files = ["Manifest", "Rakefile", "coyote.gemspec", "lib/coyote.rb"]
  s.homepage = %q{http://github.com/caseyohara/coyote}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Coyote"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{coyote}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A command-line gem to combine multiple files}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
