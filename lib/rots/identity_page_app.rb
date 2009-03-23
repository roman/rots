require 'rack/request'
require 'rack/response'
require 'rack/utils'
require 'openid'

class Rots::IdentityPageApp 
  
  def initialize(config, server_options)
    @server_options = server_options
    @config = config
  end
  
  def call(env)
    request = Rack::Request.new(env)
    flag = request.params['openid.success'] == 'true' ? '?openid.success=true' : ''
    Rack::Response.new do |response|
      response.write <<-HERE
<html>
  <head>
  <link rel="openid2.provider" href="http://localhost:#{@server_options[:port]}/server/#{flag}" />
  <link rel="openid.server" href="http://localhost:#{@server_options[:port]}/server/#{flag}" />
  </head>
  <body>
    <h1>This is #{@config['identity']} identity page</h1>
  </body>
</html>
      HERE
    end.finish
  end
  
end