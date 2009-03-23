require "openid/consumer"
require "openid/consumer/checkid_request.rb"
require "net/http"

module Rots::TestHelper
  
  def openid_request(openid_request_uri)
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