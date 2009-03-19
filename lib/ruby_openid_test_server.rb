module RubyOpenIdTestServer
  
  def self.release
    "0.0.1"
  end
  
end

require "ruby_openid_test_server/server_app"
require "ruby_openid_test_server/mock_identity_page"
require "ruby_openid_test_server/server_spec_helper"
