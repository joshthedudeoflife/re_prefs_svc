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
          #for the get, read the file back and post or put write that to a temp file
          get_get: {params: {data: :req } },
          create_post: {params: {username: :req, opt1: :req, opt2: :opt, opt3: :opt } },      
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
      KeepBusy.logger.info params.inspect 
      id = params[:id]
      file = Tempfile.new(id)
      data = file.read 
      KeepBusy.logger.info(file.path)
      file.close
      set_response  status: Response::OK , content_type: Response::JSON, content: {data: data} 
    end

    def notification_preferences_create_post
      KeepBusy.logger.info params.inspect 
      set_response  status: Response::OK , content_type: Response::JSON, content: {posted: "LIKE_THIS!", opt1: params[:opt1], opt2: params[:opt2], opt3: params[:opt3]} 
    end
    
    def notification_preferences_update_put
      KeepBusy.logger.info params.inspect 
      set_response  status: Response::OK , content_type: Response::JSON, content: {data: params[:data]}
      id = params[:id]
      file = Tempfile.new(id)
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



  end
end
