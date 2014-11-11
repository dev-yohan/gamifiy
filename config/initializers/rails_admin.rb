RailsAdmin.config do |config|


  config.authenticate_with do
     warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

    
  config.model 'Badge' do 
    
  end 

  config.model 'Sites::Site' do 
    
  end 


  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
