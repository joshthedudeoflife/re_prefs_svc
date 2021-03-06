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


  it "Action 1 Create request should create a user successfully" do
    opt = {}

    params = {data: "{\"assetclass\":[\"A\",\"B\",\"C\",\"D\"],\"states\":[\"Alabama\",\"Alaska\",\"Arizona\",\"Arkansas\",\"California\",\"Colorado\",\"Connecticut\",\"Delaware\",\"District Of Columbia\",\"Florida\",\"Georgia\",\"Hawaii\",\"Idaho\",\"Illinois\",\"Indiana\",\"Iowa\",\"Kansas\",\"Kentucky\",\"Louisiana\",\"Maine\",\"Maryland\",\"Massachusetts\",\"Michigan\",\"Minnesota\",\"Mississippi\",\"Missouri\",\"Montana\",\"Nebraska\",\"Nevada\",\"New Hampshire\",\"New Jersey\",\"New Mexico\",\"New York\",\"North Carolina\",\"North Dakota\",\"Ohio\",\"Oklahoma\",\"Oregon\",\"Pennsylvania\",\"Rhode Island\",\"South Carolina\",\"South Dakota\",\"Tennessee\",\"Texas\",\"Utah\",\"Vermont\",\"Virginia\",\"Washington\",\"West Virginia\",\"Wisconsin\",\"Wyoming\"],\"investments\":{\"minimum\":50001,\"maximum\":60000}}"}
    path = '/notification_preferences/create'    
    @requester.make_request :post, params, path, nil    
    dataobject = JSON.parse(@requester.data["data"])
    KeepBusy.logger.info("THISSSSSSS #{dataobject}")
    dataobject["states"].should include("Alabama")
    @requester.code.should == SecureApi::Response::OK
  end
  it "Action 2 Update request should update a user successfully" do
    opt = {}

    params = {id: 'abc', data: "{\"assetclass\":[\"A\",\"B\",\"C\",\"D\"],\"states\":[\"Alabama\",\"Alaska\",\"Arizona\",\"Arkansas\",\"California\",\"Colorado\",\"Connecticut\",\"Delaware\",\"District Of Columbia\",\"Florida\",\"Georgia\",\"Hawaii\",\"Idaho\",\"Illinois\",\"Indiana\",\"Iowa\",\"Kansas\",\"Kentucky\",\"Louisiana\",\"Maine\",\"Maryland\",\"Massachusetts\",\"Michigan\",\"Minnesota\",\"Mississippi\",\"Missouri\",\"Montana\",\"Nebraska\",\"Nevada\",\"New Hampshire\",\"New Jersey\",\"New Mexico\",\"New York\",\"North Carolina\",\"North Dakota\",\"Ohio\",\"Oklahoma\",\"Oregon\",\"Pennsylvania\",\"Rhode Island\",\"South Carolina\",\"South Dakota\",\"Tennessee\",\"Texas\",\"Utah\",\"Vermont\",\"Virginia\",\"Washington\",\"West Virginia\",\"Wisconsin\",\"Wyoming\"],\"investments\":{\"minimum\":50001,\"maximum\":60000}}"}
    path = '/notification_preferences/update'    
    @requester.make_request :put, params, path, nil    
    dataobject = JSON.parse(@requester.data["data"])
    KeepBusy.logger.info("Another One  #{dataobject}")
    dataobject["states"].should include("Kentucky")
    @requester.code.should == SecureApi::Response::OK
  end

  it "Action 3 Get request notification should get successful get request" do
    opt = {}

    params = {id: 'abc'}
    path = '/notification_preferences/get'    
    @requester.make_request :get, params, path, nil    
    @requester.body.should == "{\"data\":\"\"}"
    @requester.code.should == SecureApi::Response::OK
  end
end
end
