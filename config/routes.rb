Rails.application.routes.draw do
  devise_for :users, {
    :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks"
    }
  }

  root to: "boards#index"


  get("/", { :controller => "home", :action => "index" })
  
  # Routes for the Daily horoscope resource:

  # CREATE
  post("/insert_daily_horoscope", { :controller => "daily_horoscopes", :action => "create" })

  # READ
  get("/daily_horoscopes", { :controller => "daily_horoscopes", :action => "index" })

  get("/daily_horoscopes/:path_id", { :controller => "daily_horoscopes", :action => "show" })

  # UPDATE

  post("/modify_daily_horoscope/:path_id", { :controller => "daily_horoscopes", :action => "update" })

  # DELETE
  get("/delete_daily_horoscope/:path_id", { :controller => "daily_horoscopes", :action => "destroy" })

  #------------------------------

  # Routes for the Daily weather resource:

  # CREATE
  post("/insert_daily_weather", { :controller => "daily_weathers", :action => "create" })

  # READ
  get("/daily_weathers", { :controller => "daily_weathers", :action => "index" })

  get("/daily_weathers/:path_id", { :controller => "daily_weathers", :action => "show" })

  # UPDATE

  post("/modify_daily_weather/:path_id", { :controller => "daily_weathers", :action => "update" })

  # DELETE
  get("/delete_daily_weather/:path_id", { :controller => "daily_weathers", :action => "destroy" })

  #------------------------------

  # Routes for the Daily event resource:

  # CREATE
  post("/insert_daily_event", { :controller => "daily_events", :action => "create" })

  # READ
  get("/daily_events", { :controller => "daily_events", :action => "index" })

  get("/daily_events/:path_id", { :controller => "daily_events", :action => "show" })

  # UPDATE

  post("/modify_daily_event/:path_id", { :controller => "daily_events", :action => "update" })

  # DELETE
  get("/delete_daily_event/:path_id", { :controller => "daily_events", :action => "destroy" })

  #------------------------------

  #devise_for :users
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })

  #------------------------------
  # Route for Google Calendar Configuration
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #root to: "boards#index"
end
