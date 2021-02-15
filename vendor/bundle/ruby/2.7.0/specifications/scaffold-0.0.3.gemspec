# -*- encoding: utf-8 -*-
# stub: scaffold 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "scaffold".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Turnbull".freeze]
  s.date = "2010-05-14"
  s.description = "Scaffold allows you to create basic Puppet configuration, modules, nodes, classes, functions and types.".freeze
  s.email = "james@lovedthanlost.net".freeze
  s.executables = ["scaffold".freeze]
  s.files = ["bin/scaffold".freeze]
  s.homepage = "http://github.com/jamtur01/puppet-scaffold".freeze
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Scaffold is a templating tool for Puppet".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<templater>.freeze, [">= 0.5.0"])
  else
    s.add_dependency(%q<templater>.freeze, [">= 0.5.0"])
  end
end
