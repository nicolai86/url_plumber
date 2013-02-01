require 'bundler'
require 'rake/testtask'

Bundler.require

Rake::TestTask.new do |test|
  if ::RUBY_VERSION < '1.9'
    test.test_files = %w(test/url_plumber_test.rb)
  else
    test.test_files = FileList['test/*_test.rb']
  end
  # test.verbose = true
end

task :default => :test