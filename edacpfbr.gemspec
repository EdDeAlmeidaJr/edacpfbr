# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edacpfbr/version'

Gem::Specification.new do |spec|
  spec.name          = "edacpfbr"
  spec.version       = EdaCPFbr::VERSION
  spec.authors       = ["Ed de Almeida"]
  spec.email         = ["edvaldoajunior@gmail.com"]

  spec.required_ruby_version = '>= 1.9.2'

  spec.summary       = "Valida CPFs e gera lotes de CPFs aleatórios para teste."
  spec.description   = "Valida CPFs e gera lotes de CPFs aleatórios para teste. Fornece listas de CPFs válidos aleatórios."
  spec.homepage      = "https://github.com/EdDeAlmeidaJr/edacpfbr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

end
