module Processes
  class ProcessAdmin < KeepBusy
    
    attr_reader :state, :activities, :user, :attributes
    
    def initialize user, name, id=nil
      @state = nil
      @activities = []
      @user = user
      @name = name      
      @id = id
      @attributes = []
    end
    
    def current_processes 
      response = keep_busy_svc.get_current
       
      if response && response.code == 200
        return response
      else
        return nil
      end
    end
    
    
    def get
      response = keep_busy_svc.get
      
      puts response.data.to_json
      
      data = response.data   
      if data.process
        @id = data.process.id
        @name = data.process.name
        @state = data.process
        @attributes = data.process.entity_attributes
       
      else
        Rails.logger.warn "No value returned for Process.get with ID #{@id}!!!!"
      end
      response
    end    
    
    def get_form form_name, activity_id=nil
      response = keep_busy_svc.get_form form_name, activity_id
      
      Rails.logger.debug "Form response: #{response.body}"
      
      response
    end    
    
    def get_activities options = nil
      response = keep_busy_svc.get_activities options
       
      if response && response.code == 200
        return response
      else
        return nil
      end      
    end
  

  protected

    def keep_busy_svc
      return nil unless @user && @user.is_admin
      @requester ||= ReSvcClients::KeepBusyProcessAdmin.connect @user, @name, @id
    end
    

  end
end
