gem 'ruby-openid', '~> 2' if defined? Gem
require 'rack/response'
require 'rack/utils'

class RubyOpenIdTestServer::MockIdentityPage 
  
  def initialize(config)
    @config = config
  end
  
  def call(env)
    request = Rack::Request.new(env)
    flag = request.params['openid.success'] == 'true' ? '?openid.success=true' : ''
    Rack::Response.new do |response|
      response.write <<-HERE
<html>
  <head>
  <link rel="openid.server" href="http://localhost:1123/#{flag}" />
  <link rel="openid2.provider" href="http://localhost:1123/#{flag}" />
  </head>
  <body>
    <h1>This is #{@config['identity']} identity page</h1>
  </body>
</html>
      HERE
    end.finish
  end
  
end