module ReSvcClients
  class KeepBusyProcessAdmin < ReSvcClientCommon
    
    attr_accessor :name, :username, :user, :id
    
    def self.connect user, name, id=nil
      me = connection
      
      me.user = user      
      me.username = user.ext_userid
      me.name = name
      me.id = id
      
      me
    end

    
    def get_current 
      params = {username: @username, name: @name}
      path = '/process_admin/current'
      method = :get
      
      make_request method, params, path          
      self
    end

    def get
      params = {username: @username, name: @name, id: @id}
      path = '/process_admin/instance'
      method = :get
      
      make_request method, params, path          
      self
    end    

    
    def get_activities options=nil
      params = {username: @username, name: @name, id: @id}
      params.merge! options if options
      
      path = '/process_admin/activities'
      method = :get
      
      make_request method, params, path          
      self
    end
    
    
    def get_form form_name, activity_id = nil
      params = {username: @username, name: @name, id: @id, form_name: form_name, activity_id: activity_id}
      
      path = '/process_admin/form'
      method = :get
      
      make_request method, params, path
      self
    end    
    

    
  end
end
