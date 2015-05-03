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
    return [] if @env[ 'HTTP_X_SPECS' ].nil?

    @env[ 'HTTP_X_SPECS' ].split( ',' ).map( &:strip )
  end

  def body_for response
    body = ''

    response.each{| p | body += p.gsub( '<head>', "<head>#{ jasmine_requires }#{ header_specs }" )}

    body
  end

  def header_specs
    specs.map do |spec|
      "<script src='/jasmine/js/#{ spec }.js'></script>"
    end.join( "\n" )
  end

  def jasmine_requires_files
    [ 
      'jasmine_lib/jasmine.js' ,
      'jasmine_lib/jasmine-html.js',
      'jasmine_lib/boot.js',
      # 'jasmine_lib/mock-ajax.js',
      'js/SharedHelpers.js' 
    ]
  end

  def jasmine_requires
    jasmine_requires_files.map do |f|
      '<script>' + File.read( "#{ gem_dir }/lib/#{ f }") + '</script>'
    end.join
  end

  # def spec_js
  #   File.read "#{ gem_dir }/lib/app/jasmine_requires.js"
  # end

  def gem_dir
    '../../gems/capybara-jasmine'
  end
end