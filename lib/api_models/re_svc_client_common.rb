module ReSvcClients  
  class ReSvcClientCommon < ReSvcClient::Requester
    
    def self.configuration= config           
      puts "Setting configuration (#{self}): #{config}"
      @configuration = config
    end

    def self.connect
      connection
    end
    
    # Make connection to the backend service
    # By default it will take the name of the class to use to lookup the connection details
    def self.connection re_svc=nil
      
      re_svc ||= self.name.to_sym       
      config = @configuration
      
     # Rails.logger.debug "CONFIGURATION (#{self}): #{@configuration.inspect} "
      
      server = "#{config[:protocol]}://#{config[:server]}:#{config[:port]}"
        
     # Rails.logger.debug "Connecting #{server}"      
      
      return new server, config[:client], config[:secret]
    end  
    
  end
end
