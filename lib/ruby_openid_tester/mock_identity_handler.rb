gem 'ruby-openid', '~> 2' if defined? Gem
require 'rack/response'
require 'rack/utils'

class RubyOpenIdTester::MockIdentityHandler 
  
  def initialize()
  end
  
  def call(env)
    Rack::Response.new do |response|
      response.write <<-HERE
<html>
  <head>
  <link rel="openid.server" href="http://localhost:1123/" />
  <link rel="openid2.provider" href="http://localhost:1123" />
  </head>
  <body>
  </body>
</html>
      HERE
    end.finish
  end
  
end