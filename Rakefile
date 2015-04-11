require 'rake/testtask'

Rake::TestTask.new do |t|
  t.name = 'test:texterra'
  t.libs << 'test'
  t.test_files = ['test/test_texterra_api.rb']
end

Rake::TestTask.new do |t|
  t.name = 'test:twitter'
  t.libs << 'test'
  t.test_files = ['test/test_twitter_api.rb']
end

task test: ['test:texterra', 'test:twitter']

desc 'Run all tests'
task default: :test
