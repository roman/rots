require "openid/consumer"
require "openid/consumer/checkid_request.rb"
require "net/http"
#require "rots/server_app"

module Rots::TestHelper
  
  def self.included(base)
    #base.class_eval do
    #  cattr_accessor :rots_config
    #  cattr_accessor :rots_server_options
    #end
    #[:verify_discovery_results, :check_signature].each do |method_name|
    #  OpenID::Consumer::IdResHandler.class_eval { define_method(method_name) { } }
    #end
  end
  
  def openid_request(openid_request_uri)
    openid_response = Net::HTTP.get_response(URI.parse(openid_request_uri))
    
    #handler = RubyOpenIdTestServer::ServerApp.new(self.rots_config, self.rots_server_options)
    #openid_request = Rack::MockRequest.new(handler)

    #openid_response = openid_request.get(openid_request_uri)
    #openid_response_uri = URI(openid_response.headers['Location'])
    #openid_response_qs = Rack::Utils.parse_query(openid_response_uri.query)
    
    openid_response = Net::HTTP.get_response(URI.parse(openid_request_uri))
    openid_response_uri = URI(openid_response['Location'])
    openid_response_qs = Rack::Utils.parse_query(openid_response_uri.query)
    
    # invoking the OpenID consumer with the options of the response of the ServerApp
    if defined?(Webrat)
      visit(openid_response_uri.to_s)
    else
      # NOTE: Works on Rails and Merb frameworks via duck typing
      # later we will check on Sinatra
      get(openid_response_uri.path, openid_response_qs)
    end
  end
  
end