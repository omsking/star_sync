class DailyWeathersController < ApplicationController
  def index
    render({ :template => "homepage/index" })
end
