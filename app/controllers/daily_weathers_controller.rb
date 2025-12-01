class DailyWeathersController < ApplicationController
  def index
    matching_daily_weathers = DailyWeather.all

    @list_of_daily_weathers = matching_daily_weathers.order({ :created_at => :desc })

    render({ :template => "daily_weather_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_daily_weathers = DailyWeather.where({ :id => the_id })

    @the_daily_weather = matching_daily_weathers.at(0)

    render({ :template => "daily_weather_templates/show" })
  end

  def create
    the_daily_weather = DailyWeather.new
    the_daily_weather.temperature = params.fetch("query_temperature")
    the_daily_weather.rain_percentage = params.fetch("query_rain_percentage")
    the_daily_weather.snow_percentage = params.fetch("query_snow_percentage")
    the_daily_weather.sun_percentage = params.fetch("query_sun_percentage")
    the_daily_weather.user_id = params.fetch("query_user_id")

    if the_daily_weather.valid?
      the_daily_weather.save
      redirect_to("/daily_weathers", { :notice => "Daily weather created successfully." })
    else
      redirect_to("/daily_weathers", { :alert => the_daily_weather.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_daily_weather = DailyWeather.where({ :id => the_id }).at(0)

    the_daily_weather.temperature = params.fetch("query_temperature")
    the_daily_weather.rain_percentage = params.fetch("query_rain_percentage")
    the_daily_weather.snow_percentage = params.fetch("query_snow_percentage")
    the_daily_weather.sun_percentage = params.fetch("query_sun_percentage")
    the_daily_weather.user_id = params.fetch("query_user_id")

    if the_daily_weather.valid?
      the_daily_weather.save
      redirect_to("/daily_weathers/#{the_daily_weather.id}", { :notice => "Daily weather updated successfully." } )
    else
      redirect_to("/daily_weathers/#{the_daily_weather.id}", { :alert => the_daily_weather.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_daily_weather = DailyWeather.where({ :id => the_id }).at(0)

    the_daily_weather.destroy

    redirect_to("/daily_weathers", { :notice => "Daily weather deleted successfully." } )
  end
end
