# -*- encoding: utf-8 -*-
# stub: vagrant-reload 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "vagrant-reload".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aidan Nagorcka-Smith".freeze]
  s.date = "2013-10-14"
  s.description = "Enables reloading a vagrant VM as a provisioning step.".freeze
  s.email = "aidanns@gmail.com".freeze
  s.homepage = "http://www.vagrantup.com".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Enables reloading a vagrant VM as a provisioning step.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
