# coding: utf-8
require File.expand_path('../lib/vagrant-chefnode/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "vagrant-chefnode"
  spec.version       = Vagrant::Chefnode::VERSION
  spec.authors       = ["Ryutaro YOSHIBA"]
  spec.email         = ["ryuzee@gmail.com"]
  spec.description   = %q{Remove nodes and clients from Chef Server when instances are destroyed}
  spec.summary       = %q{Remove nodes and clients from Chef Server when instances are destroyed}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "chef", ">= 11.4.0"
end
