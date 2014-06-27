$baseurl = 'localhost'
$port = 5701
$server = "http://#{$baseurl}:#{$port}"

require './lib/client/requester'

describe '/admin#status' do
  before(:all) do        
    test_client = 'test_admin'
    secret = SecureApi::ClientSecret.create(test_client, :replace_client=>true)       
    @requester = ReSvcClient::Requester.new $server, test_client, secret
  end
  
  it "should check status of server - if it fails, ensure the server is running" do        
    params = {}
    path = '/admin/status'      
    @requester.make_request :get, params, path
    @requester.code.should == SecureApi::Response::OK   
  end
  

describe '/notification_preferences' do
  before(:all) do
    
    # clear up first
    test_client = 'test_client'
    secret = SecureApi::ClientSecret.create(test_client, :replace_client=>true)
    @requester = ReSvcClient::Requester.new $server, test_client, secret
  end

  it "Action 1 Get request notification should get successful get request" do
    opt = {}

    params = {data: 'stuff'}
    path = '/notification_preferences/get'    
    @requester.make_request :get, params, path, nil    
    @requester.body.should == "{\"data\":\"stuff\"}"
    @requester.code.should == SecureApi::Response::OK
  end
  it "Action 2 Create request should create a user successfully" do
    opt = {}

    params = {username: 'phil', password: 'hello phil', opt1: 'this', opt2: 'more', opt3: 'go for it'}
    path = '/notification_preferences/create'    
    @requester.make_request :post, params, path, nil    
    @requester.body.should == "{\"posted\":\"LIKE_THIS!\",\"opt1\":\"this\",\"opt2\":\"more\",\"opt3\":\"go for it\"}"
    @requester.code.should == SecureApi::Response::OK
  end
  it "Action 3 Update request should update a user successfully" do
    opt = {}

    params = {username: 'phil', password: 'hello phil', opt1: 'ok', opt2: 'so', opt3: 'go for it'}
    path = '/notification_preferences/update'    
    @requester.make_request :put, params, path, nil    
    @requester.body.should == "{\"opt1\":\"ok\",\"opt2\":\"so\",\"opt3\":\"go for it\"}"
    @requester.code.should == SecureApi::Response::OK
  end
end
end
