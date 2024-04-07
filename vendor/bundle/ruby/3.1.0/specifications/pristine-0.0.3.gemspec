# -*- encoding: utf-8 -*-
# stub: pristine 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "pristine".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Carla Souza".freeze]
  s.date = "2016-04-19"
  s.description = "Watches if any file managed by Puppet was modified.".freeze
  s.email = ["contact@carlasouza.com".freeze]
  s.executables = ["pristine".freeze]
  s.files = ["bin/pristine".freeze]
  s.homepage = "https://github.com/carlasouza/pristine".freeze
  s.licenses = ["GPL-3.0".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Pristine configuration files.".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rb-inotify>.freeze, ["~> 0.9.7"])
  else
    s.add_dependency(%q<rb-inotify>.freeze, ["~> 0.9.7"])
  end
end
