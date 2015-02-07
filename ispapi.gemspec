require "./lib/ispapi/version"

Gem::Specification.new do |s|
  s.name        = 'ispapi'
  s.version     = Version.current
  s.date        = Version.current_date
  s.files       = `git ls-files`.split($\)
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'httparty', '~> 0.13.3'
  s.add_runtime_dependency 'nori', '~> 2.4.0'
  s.add_development_dependency 'rake', '~> 10.4.2'
  s.add_development_dependency 'minitest', '~> 5.5.0'
  s.add_development_dependency 'dotenv', '~> 1.0.2'
  s.summary     = "ISPRAS API Ruby SDK"
  s.authors     = ["Alexey Laguta"]
  s.email       = 'laguta@ispras.ru'
end