## A test implementation to allow api_http_spec tests to run and exercise the API
# It also should make a good skeleton from which to create real implementations
require 'tempfile'
require 'net/http'
module SecureApi
  #cleanup the routes that are no longer needed, update, and get in notification_prefernces
  class Implementation < SecureApi::ApiControl    
    
    def routes
      {
        
         notification_preferences: {
          get_get: {params: {id: :req} },
          create_post: {params: {data: :req} },      
          update_put: {params: {data: :req }},
          
        },
        admin: {
          status_get: {}
        }
      }
    end

    def bad_request?
      false
    end


    def notification_preferences_get_get
      KeepBusy.logger.info("this is line 31 #{params.inspect}")
      id = params[:id]
      begin
        file = File.open("/Users/joshthedudeoflife/re_prefs_files/#{id}")
        data = file.read 
        KeepBusy.logger.info(file.path)
        file.close
        set_response  status: Response::OK , content_type: Response::JSON, content: {data: data}
        KeepBusy.logger.info("Lets go here")
      rescue
        set_response  status: Response::NOT_FOUND
        KeepBusy.logger.info("this is where we are")
      end
    end

    def notification_preferences_create_post
      KeepBusy.logger.info params.inspect 
      id = "abc#{rand(10000000000)}"
      file = File.new("/Users/joshthedudeoflife/re_prefs_files/#{id}", "w")
      file.write params[:data]
      #push this data to a new create method, params[:data] needs to be parsed to JSON
      KeepBusy.logger.info(file.path)
      file.close
      set_response  status: Response::OK , content_type: Response::JSON, content: {data: params[:data], id: id}
    end
    
    def notification_preferences_update_put
      KeepBusy.logger.info params.inspect 
      set_response  status: Response::OK , content_type: Response::JSON, content: {data: params[:data]}
      id = params[:id]
      file = File.new("/Users/joshthedudeoflife/re_prefs_files/#{id}", "w")
      file.write params[:data]
      KeepBusy.logger.info(file.path)
      file.close
    end
    
    # An example of a callback method definition for the appropriate controller, action, method 
    # Notice that this is prefixed with self. since it is initially referenced against the class
    # not an instance of the object.
    # Note that it is the responsibility of the callback to call response.send_response in order to mark the end of
    # the HTTP request
    # The arguments passed in provide control:
    #   result: the original set_response hash as set by the 
    #           controller_action_method implementation
    #   request: the ApiServer instance that was instantiated during the call
    #           which can be used to access the original params hash
    
    def admin_status_get
      set_response status: Response::OK, content_type: Response::JSON, content: {} 
    end

    def get_from_es(id)
      @data = ES_INDEX.get(id, {preference: '_primary'})
    end

    def put_to_es(id,data)

    end

    def create_to_est()

    end
    #create a create method in the notification prefs create action, try calling the create method and use CURL to see if it made
    #into elastic search

  end
end
