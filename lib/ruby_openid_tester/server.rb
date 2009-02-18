gem 'ruby-openid', '~> 2' if defined? Gem
require 'rack/request'
require 'rack/utils'
require 'openid' #gem
require 'openid/extension' #gem
require 'openid/store/memory' #gem
require 'openid/util'


module RubyOpenIdTester
  
  class ServerHandler
    
    attr_accessor :request,:openid_request,
                  :response, :openid_response,
                  :server
    
    def initialize()
    end
    
    def call(env)
      create_wrappers(env)
      if !is_checkid_request?
        @openid_response = @server.handle_request(@openid_request)
        reply_consumer
      elsif is_checkid_immediate?
        process_immediate_checkid_request
      else
        process_checkid_request
      end
    end
    
    protected
    
    def create_wrappers(env)
      @request = Rack::Request(env)
      @server  = OpenID::Server::Server.new(OpenID::Store::Memory.new, @request)
      @openid_request = @server.decode_request(@request.params)
    end
    
    def is_checkid_request?
      @openid_request.is_a?(OpenID::Server::CheckIDRequest)
    end
    
    def is_checkid_immediate?
      @openid_request && @openid_request.immediate
    end
    
    def process_immediate_checkid_request
      # TODO: We should enable the user to configure
      # if she wants immediate request support or not
      url = OpenID::Util.append_args(@openid_request.return_to, 
        @request.params.merge('openid.mode' => 'setup_needed'))
      redirect(url)
    end
    
    def process_checkid_request
      if checkid_request_is_valid?
        return_successful_openid_response
      else
        return_cancel_openid_response
      end
    end
    
    def checkid_request_is_valid?
      @request.params['test.openid.auth'] == 'true'
    end
    
    def return_successful_openid_response
      @openid_response = @openid_request.answer(true)
      @openid_server.signatory.sign(@openid_response) if @openid_response.needs_signing
      reply_consumer
    end
    
    def return_cancel_openid_response
      redirect(@openid_request.cancel_url)
    end
    
    def reply_consumer
      web_response = @openid_server.encode_response(@openid_response)
      case web_response.code
      when OpenID::Server::HTTP_OK
        success(web_response.body)
      when OpenID::Server::HTTP_REDIRECT
        redirect(web_response.headers['location'])
      else
        failure(web_response.body)
      end   
    end
    
  end

end