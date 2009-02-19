require File.join(File.dirname(__FILE__), 'spec_helper')

describe RubyOpenIdTester::ServerHandler do

  describe "when the request is not an OpenID request" do

    it "should return a helpful message saying that is an OpenID endpoint" do
      request  = Rack::MockRequest.new(RubyOpenIdTester::ServerHandler.new)
      response = request.get("/")
      response.should be_ok
      response.body.should == "This is an OpenID endpoint"
    end

  end

  describe "when the request is an OpenID request" do
    
    before(:each) do
      @request = Rack::MockRequest.new(RubyOpenIdTester::ServerHandler.new)
    end
    
    describe "without the SREG extension" do

      describe "and it is a check_id request" do

        describe "and is immediate" do

          it "should return an openid.mode equal to setup_needed" do
            response = checkid_immediate(@request)
            params = openid_params(response)
            params['openid.mode'].should == 'setup_needed'
          end

        end

        describe "and is not immediate" do

          describe "with a success flag" do

            it "should return an openid.mode equal to id_res" do
              response = checkid_setup(@request, 'test.openid' => 'true')
              params = openid_params(response)
              params['openid.mode'].should == 'id_res'
            end

          end

          describe "without a success flag" do

            it "should return an openid.mode equal to cancel" do
              response = checkid_setup(@request)
              params = openid_params(response)
              params['openid.mode'].should == 'cancel'
            end

          end
        
        end
      end
    end
  end
end