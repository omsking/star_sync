class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # Check if user has a horoscope for today
    @dailyhoroscope = current_user.daily_horoscopes.find_by(
      "DATE(created_at) = ?", Date.today
    )

    # If no horoscope exists for today, create one
    if @dailyhoroscope.nil?
      # Create a new horoscope record
      @dailyhoroscope = current_user.daily_horoscopes.create

      # Initialize AI Chat
      c = AI::Chat.new

      # Set system context for horoscope generation
      c.system("You are an expert astrologer who creates personalized daily horoscopes based on birth information. Provide a funny, light-hearted daily horoscope reading based on birth date, and on birth location/time if provided. This horoscope should only be one sentence, and your response shouldn't include anything other than the one-sentence horoscope. The horoscope can be kind or saracastic, but it shouldn't be mean or too dark. Good themes include friendships, relationships, or career. The horoscope doesn't need to be directive or logical.")

      # Prepare user birth information
      birth_info = "Birth Date: #{current_user.birth_date}, Birth Location: #{current_user.birth_location}, Birth Time: #{current_user.birth_time}. Please provide a personalized daily horoscope for #{Date.today}."

      # Generate horoscope with AI
      c.user(birth_info)
      ai_response = c.generate!

      # Update the horoscope record with AI response
      @dailyhoroscope.update(horoscope: ai_response)
    end

    render({ :template => "home_templates/index" })
  end
end
