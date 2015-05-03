def capybara_app
  Rack::Builder.new do
    use SpecInjector
    use Rack::Static, urls:[ '/jasmine' ], root:'spec'
    use Rack::Static, urls:[ '/capybara-jasmine' ], root:gem_dir
    
    use Rack::Static, root:'public'
    run App
    # run app
  end.to_app
end

def gem_dir
  File.join(File.dirname(File.expand_path(__FILE__)), '../../lib')
end

puts `ls -l #{ gem_dir }`
puts `ls -l #{ gem_dir }/jasmine_lib`