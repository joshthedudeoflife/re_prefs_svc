Rails.application.config.to_prepare do



  ReSvcClients::KeepBusyProcessAdmin.configuration =  
    {
      client: 'some_client',
      secret: 'abcdefeksdjhfksdahfjkhdasfjyywqehr2364786236',
      protocol: 'http',
      server: 're-prefs-svc.repse.internal', #http://localhost:8000
      port: Socket.getservbyname('re-prefs-svc')
    }  
  
end
