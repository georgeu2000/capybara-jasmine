class SpecInjector
  def initialize app
    @app = app
  end

  def call env
    @env = env
    
    status, headers, response = @app.call( env )

    if status != 200
      puts red( "#{ env[ 'PATH_INFO' ] } #{ status }")
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
    return []  if @env[ 'HTTP_X_SPECS' ].blank?

    @env[ 'HTTP_X_SPECS' ].split( ',' ).map( &:strip )
  end

  def body_for response
    body = ''
    response.each{| p | body += p.gsub( '<head>', "#{ spec_js }#{ header_specs }<head>" )}

    body
  end

  def header_specs
    specs.map do |spec|
      "<script src='/jasmine/js/#{ spec }.js'></script>"
    end.join( "\n" )
  end

  def spec_js
    File.read 'spec/jasmine/app/jasmine_requires.js'
  end 
end