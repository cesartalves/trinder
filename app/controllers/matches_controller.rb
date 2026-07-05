class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: :show

  def index
    @matches = Match.where("user_1_id = :id OR user_2_id = :id", id: current_user.id)
  end

  def show
  @match = Match.find(params[:id])

  unless [@match.user_1_id, @match.user_2_id].include?(current_user.id)
    redirect_to matches_path, alert: "You cannot access this match."
    return
  end

  @other_user = @match.user_1 == current_user ? @match.user_2 : @match.user_1
  @messages = @match.messages.includes(:user).order(:created_at)
  @message = Message.new
end

  private

  def set_match
    @match = Match.find_by(id: params[:id])
    return redirect_to matches_path, alert: "Match not found." unless @match
    return redirect_to matches_path, alert: "Not authorized." unless [@match.user_1_id, @match.user_2_id].include?(current_user.id)
  end
end
