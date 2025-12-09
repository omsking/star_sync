class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # Daily Horoscope
    # Check if user has a horoscope for today
    @dailyhoroscope = current_user.daily_horoscopes.find_by(
      "DATE(created_at) = ?", Date.today
    )

    # If no horoscope exists for today, create one
    if @dailyhoroscope.nil?
      
      # Build a new daily record for this user
      @dailyhoroscope = current_user.daily_horoscopes.new

      # Initialize Chat
      c = AI::Chat.new

      # System prompt
      c.system("You are an expert astrologer who creates personalized daily horoscopes based on birth information. Provide a funny, light-hearted daily horoscope reading based on birth date, and on birth location/time if provided. This horoscope should only be one sentence, and your response shouldn't include anything other than the one-sentence horoscope. The horoscope can be kind or saracastic, but it shouldn't be mean or too dark. Good themes include friendships, relationships, or career. The horoscope doesn't need to be directive or logical.")

      # User birth information
      birth_info = "Birth Date: #{current_user.birth_date}, Birth Location: #{current_user.birth_location}, Birth Time: #{current_user.birth_time}. Please provide a personalized daily horoscope for #{Date.today}."

      c.user(birth_info)

      # Generate response
      c.generate!

      # Get the reply text
      ai_text = c.last
      clean_resp = ai_text.fetch(:content)

      # Save on the record
      @dailyhoroscope.horoscope = clean_resp
      @dailyhoroscope.save
    end

    # Daily Weather (update every login)
    # Set user location and find coordinates
    @user_location = current_user.current_location
    @maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @user_location + "&key=" + ENV.fetch("GMAPS_KEY")

    raw_resp = HTTP.get(@maps_url)
    parsed_resp = JSON.parse(raw_resp)
    results = parsed_resp.fetch("results")
    results_array = results.at(0)
    geometry = results_array.fetch("geometry")

    location = geometry.fetch("location")
    lat = location.fetch("lat")
    lng = location.fetch(("lng"))

    # Get weather data
    weather_url = "https://api.pirateweather.net/forecast/" + ENV.fetch("PIRATE_WEATHER_KEY") + "/" + lat.to_s + "," + lng.to_s
    raw_weather = HTTP.get(weather_url)
    parsed_weather = JSON.parse(raw_weather)

    # Current weather data
    currently_hash = parsed_weather.fetch("currently")
    @current_temp = currently_hash.fetch("temperature")
    @current_summary = currently_hash.fetch("summary")

    # Weather forecast
    hourly_hash = parsed_weather.fetch("hourly")
    hourly_array = hourly_hash.fetch("data")

    # Look at precipitation data
    @precipcount = 0
    hourly_array[0..11].each_with_index do |precip, index|
      if precip.fetch("precipProbability") >= 0.10
        @precipcount += 1
      end
    end

    # Look at cloud cover data
    @cloudycount = 0
    hourly_array[0..11].each_with_index do |cloudy, index|
      if cloudy.fetch("cloudCover") >= 0.875
        @cloudycount += 1
      end
    end

    # Look at temperature data
   @coldcount = 0
    hourly_array[0..11].each_with_index do |cold, index|
      if cold.fetch("temperature") <= 32
        @coldcount += 1
      end
    end

    # Render view template
    render({ :template => "home_templates/index" })
  end
end
