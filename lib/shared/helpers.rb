def run_specs specs
  page.driver.header 'Content-Type', 'text/html'
  page.driver.header 'X-Specs', specs
end

def display_js_errors
  return unless Capybara.current_driver.match /webkit/

  if page.driver.error_messages.present?
    puts red 'Javascript errors:'
  else
    puts cyan 'No Javascript errors.'
  end

  page.driver.error_messages.each do |m|
    puts red( "  #{ filename_for m[ :source ]}: Line #{ m[ :line_number ]}: #{ m[ :message ]}" )
  end
end

def filename_for url
  url.gsub /https?:\/\/.*?\//, ''
end

def display_js_console
  return unless Capybara.current_driver == :webkit

  if page.driver.console_messages.present?
    puts magenta( "Javascript console:")
  end

  page.driver.console_messages.each do |m|
    puts magenta( "  #{ filename_for m[ :source ]}: Line #{ m[ :line_number ]}: #{ m[ :message ]}" )
  end
end

def display_jasmine_specs
  puts cyan( jasmine_suites )
  color_print jasmine_result
end

def jasmine_result
  result = js_body.match( /\d+\s+specs?,\s+\d+\s+failures?/ ).to_s

  if result.match /,\s+0 failure/
    "Jasmine Success: #{ result }"
  else
    "Jasmine Failure: #{ result }\n" + jasmine_failures
  end
end

def jasmine_failures
  html_doc = Nokogiri::HTML( js_body )
  html_doc.css( 'div .result-message' )
          .map{|div| "  #{ div.text }"}
          .join( "\n" )
end

def jasmine_suites
  html_doc = Nokogiri::HTML( js_body )
  html_doc.css( 'div .suite' ).map do | suite |
    suite.at_css( '.suite-detail' ).text +
    suite.css( 'ul.specs' ).map{| spec | "\n  #{ spec.text }"}.join
  end.join
end

def js_body
  page.evaluate_script( 'document.documentElement.innerHTML' )
end

def color_print text
  unless text.match /failure/
    puts red( 'Jasmine specs failed to run.' )
    return
  end

  if text.match /,\s+0 failures/
    puts cyan( text )
  else
    puts red( text )
  end
end

def colorize color_code, text
  "\e[#{color_code}m#{text}\e[0m"
end

def red text
  colorize 31, text
end

def green text
  colorize 32, text
end

def blue text
  colorize 34, text
end

def magenta text
  colorize 35, text
end

def cyan text
  colorize 36, text
end
