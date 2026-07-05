class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match

  def create
    @message = @match.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to match_path(@match)
    else
      redirect_to match_path(@match), alert: "Message can't be blank."
    end
  end

  private

  def set_match
    @match = Match.find(params[:match_id])

    unless [@match.user_1_id, @match.user_2_id].include?(current_user.id)
      redirect_to matches_path, alert: "You cannot access this chat."
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end