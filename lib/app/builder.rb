def capybara_app
  Rack::Builder.new do
    use SpecInjector
    use Rack::Static, urls:[ '/jasmine' ], root:'spec'
    
    use Rack::Static, root:'public'
    run App
  end.to_app
end