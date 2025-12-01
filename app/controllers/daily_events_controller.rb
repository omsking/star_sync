class DailyEventsController < ApplicationController
  def index
    matching_daily_events = DailyEvent.all

    @list_of_daily_events = matching_daily_events.order({ :created_at => :desc })

    render({ :template => "daily_event_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_daily_events = DailyEvent.where({ :id => the_id })

    @the_daily_event = matching_daily_events.at(0)

    render({ :template => "daily_event_templates/show" })
  end

  def create
    the_daily_event = DailyEvent.new
    the_daily_event.color = params.fetch("query_color")
    the_daily_event.user_id = params.fetch("query_user_id")

    if the_daily_event.valid?
      the_daily_event.save
      redirect_to("/daily_events", { :notice => "Daily event created successfully." })
    else
      redirect_to("/daily_events", { :alert => the_daily_event.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_daily_event = DailyEvent.where({ :id => the_id }).at(0)

    the_daily_event.color = params.fetch("query_color")
    the_daily_event.user_id = params.fetch("query_user_id")

    if the_daily_event.valid?
      the_daily_event.save
      redirect_to("/daily_events/#{the_daily_event.id}", { :notice => "Daily event updated successfully." } )
    else
      redirect_to("/daily_events/#{the_daily_event.id}", { :alert => the_daily_event.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_daily_event = DailyEvent.where({ :id => the_id }).at(0)

    the_daily_event.destroy

    redirect_to("/daily_events", { :notice => "Daily event deleted successfully." } )
  end
end
