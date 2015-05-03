class SpecInjector
  def initialize app
    @app = app
  end

  def call env
    ap :call
    @env = env
    
    status, headers, response = @app.call( env )

    if status != 200
      puts red( "capybara-jasmine HTTP request error: #{ status } #{ env[ 'PATH_INFO' ] }")
    else
      puts green( "capybara-jasmine HTTP request success: #{ status } #{ env[ 'PATH_INFO' ] }")
    end

    if env[ 'HTTP_ACCEPT' ] && env[ 'HTTP_ACCEPT' ].include?( 'text/html' )
      body = body_for( response )
      
      headers[ 'Content-Length' ] = body.length.to_s
      
      [ status, headers, [ body ]]
    else  
      [ status, headers, response ]
    end  
  end

  def specs
    return [] if @env[ 'HTTP_X_SPECS' ].nil?

    @env[ 'HTTP_X_SPECS' ].split( ',' ).map( &:strip )
  end

  def body_for response
    body = ''

    response.each{| p | body += p.gsub( '<head>', "<head>#{ jasmine_requires }#{ header_specs }" )}

    body
  end

  def header_specs
    "\n" + specs.map do |spec|
      "<script src='/jasmine/js/#{ spec }.js'></script>"
    end.join( "\n" ) + "\n"
  end

  def jasmine_requires_files
    [ 
      # 'vendor/jquery.2.1.3.min.js',
      'jasmine_lib/jasmine.js' ,
      # 'jasmine_lib/jasmine-html.js',
      # 'jasmine_lib/boot.js',
      # 'jasmine_lib/mock-ajax.js',
      # 'js/SharedHelpers.js' 
    ]
  end

  def jasmine_requires
    "\n" + jasmine_requires_files.map do |f|
      "<script src='/capybara-jasmine/#{ f }'></script>"
    end.join( "\n" )
  end
end