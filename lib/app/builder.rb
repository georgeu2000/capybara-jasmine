def capybara_app
  Rack::Builder.new{
    use SpecInjector
    use Rack::Static, urls:static_paths,   root:'public'
    use Rack::Static, urls:[ '/jasmine' ], root:'spec'
    
    run BetterPRWriter
  }.to_app
end