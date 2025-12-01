class DailyHoroscopesController < ApplicationController
  def index
    matching_daily_horoscopes = DailyHoroscope.all

    @list_of_daily_horoscopes = matching_daily_horoscopes.order({ :created_at => :desc })

    render({ :template => "daily_horoscope_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_daily_horoscopes = DailyHoroscope.where({ :id => the_id })

    @the_daily_horoscope = matching_daily_horoscopes.at(0)

    render({ :template => "daily_horoscope_templates/show" })
  end

  def create
    the_daily_horoscope = DailyHoroscope.new
    the_daily_horoscope.user_id = params.fetch("query_user_id")
    the_daily_horoscope.horoscope = params.fetch("query_horoscope")

    if the_daily_horoscope.valid?
      the_daily_horoscope.save
      redirect_to("/daily_horoscopes", { :notice => "Daily horoscope created successfully." })
    else
      redirect_to("/daily_horoscopes", { :alert => the_daily_horoscope.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_daily_horoscope = DailyHoroscope.where({ :id => the_id }).at(0)

    the_daily_horoscope.user_id = params.fetch("query_user_id")
    the_daily_horoscope.horoscope = params.fetch("query_horoscope")

    if the_daily_horoscope.valid?
      the_daily_horoscope.save
      redirect_to("/daily_horoscopes/#{the_daily_horoscope.id}", { :notice => "Daily horoscope updated successfully." } )
    else
      redirect_to("/daily_horoscopes/#{the_daily_horoscope.id}", { :alert => the_daily_horoscope.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_daily_horoscope = DailyHoroscope.where({ :id => the_id }).at(0)

    the_daily_horoscope.destroy

    redirect_to("/daily_horoscopes", { :notice => "Daily horoscope deleted successfully." } )
  end
end
