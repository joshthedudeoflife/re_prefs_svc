## A test implementation to allow api_http_spec tests to run and exercise the API
# It also should make a good skeleton from which to create real implementations
require 'stretcher'
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
        data = get_from_es(id)
        set_response  status: Response::OK , content_type: Response::JSON, content: {data: data}
      rescue => e
        set_response  status: Response::NOT_FOUND
        KeepBusy.logger.info("an error occur in GET #{e.inspect} #{e.backtrace.join("\n")}")
      end
    end

    def notification_preferences_create_post
      KeepBusy.logger.info("HELLLLLLLLOOOOOO") 
      json_data = params[:data]
      dataobject = JSON.parse(json_data)
      id = create_to_es(dataobject)
    
      set_response  status: Response::OK , content_type: Response::JSON, content: {data: dataobject, id: id}
    end
    
    def notification_preferences_update_put
      KeepBusy.logger.info(params[:id])
      id_params = params[:id]
      json_data = params[:data]
      dataobject = JSON.parse(json_data)
      data = put_to_es(id_params, dataobject)
      KeepBusy.logger.info(dataobject)
      set_response  status: Response::OK , content_type: Response::JSON, content: {data: dataobject, id: id_params}
     
    end
    
    
    def admin_status_get
      KeepBusy.logger.info("admin_status_get")
      set_response status: Response::OK, content_type: Response::JSON, content: {} 
    end

    def get_from_es(id)
    res = KeepBusy::ES_INDEX.type(:user_preference).get(id)

    end

    def put_to_es(id,data)
     res = KeepBusy::ES_INDEX.type(:user_preference).put(id, data) 
    end

    def create_to_es(data)
    KeepBusy.logger.info("ES_INDEX CHECK")
    res = KeepBusy::ES_INDEX.type(:user_preference).post( data) 
    res._id
    end

  end
end
