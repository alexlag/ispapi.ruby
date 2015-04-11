require './lib/ispras-api/version'

Gem::Specification.new do |s|
  s.name        = 'ispras-api'
  s.version     = Version.current
  s.date        = Version.current_date
  s.files       = `git ls-files`.split($\)
  s.require_paths = ['lib']
  s.add_runtime_dependency 'httparty', '~> 0.13'
  s.add_runtime_dependency 'nori', '~> 2.4'
  s.add_development_dependency 'rake', '~> 10.4'
  s.add_development_dependency 'minitest', '~> 5.5'
  s.add_development_dependency 'dotenv', '~> 1.0'
  s.summary     = 'ISPRAS API Ruby SDK'
  s.description     = 'This is Ruby wrapper for REST API provided by ISPRAS. More info at https://api.ispras.ru/'
  s.homepage = 'https://github.com/alexlag/ispapi.ruby'
  s.authors     = ['Alexey Laguta']
  s.email       = 'laguta@ispras.ru'
end
