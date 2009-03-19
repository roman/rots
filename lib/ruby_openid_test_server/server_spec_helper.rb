require "server_app"

module RubyOpenIdTestServer::ServerSpecHelper
  
  def config=(config)
    @config = config
  end
  
  def server_options=(server_options)
    @server_options = server_options
  end
  
  def openid_request(openid_request_uri)
    openid_request_uri = URI(openid_request_uri)
    handler = RubyOpenIdTestServer::ServerApp.new(@config['sreg'], @server_options)
    openid_request = Rack::MockRequest.new(handler)
    openid_request_qs = "/server?%s" % openid_request_uri.query 
    
    openid_response = openid_request.get(openid_request_qs)
    openid_response_uri = URI(openid_response.headers['Location'])
    
    # invoking the OpenID consumer with the options of the response of the ServerApp
    get(Rack::Utils.parse_query(openid_response_uri.query))
  end
  
end