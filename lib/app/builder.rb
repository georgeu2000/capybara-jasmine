def capybara_app
  Rack::Builder.new do
    use SpecInjector
    use Rack::Static, urls:[ '/jasmine' ], root:'spec'
    use Rack::Static, urls:[ '/capybara-jasmine-files' ], root:gem_dir
    
    run app
  end.to_app
end


def gem_dir
  File.join(File.dirname(File.expand_path(__FILE__)), '../../lib')
end

ap gem_dir