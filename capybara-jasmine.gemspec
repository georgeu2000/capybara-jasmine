 Gem::Specification.new do |s|
  s.name        = 'capybara-jasmine'
  s.version     = '0.1.3'
  s.date        = '2015-05-04'
  s.summary     = 'Run Jasmine specs with Capybara.'
  s.description = 'This gem allows you to run Jasmine specs with Capybara for a Rack app.'
  s.authors     = ['George Ulmer']
  s.email       = 'george@boost-media.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'http://rubygems.org/gems/capybara-jasmine'
  s.license     = 'MIT'

  s.add_dependency 'rack', ['1.6.0']
  s.add_dependency 'rspec', ['3.2']
  s.add_dependency 'rack-test', ['0.6.3']
  s.add_dependency 'guard', ['2.12']
  s.add_dependency 'capybara', ['2.4.4']
  s.add_dependency 'capybara-webkit', ['1.5.0']
  s.add_dependency 'selenium-webdriver', ['2.45.0']
  s.add_dependency 'awesome_print', ['1.6.1']
end