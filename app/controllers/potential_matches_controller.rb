class PotentialMatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @potential_match = find_or_create_potential_match
  end

  def like
    @potential_match = find_or_create_potential_match
   
    if @potential_match.liked? && @potential_match.liked_by != current_user
      ActiveRecord::Base.transaction do
        match = Match.create!(
          user_1: @potential_match.user_1,
          user_2: @potential_match.user_2
        )

        @potential_match.update!(
          state: :matched,
          match: match
        )
      end
    elsif @potential_match.potential?
      @potential_match.update!(
        state: :liked,
        liked_by: current_user
      )
    else
      return redirect_to root_path, alert: "This match can no longer be updated."
    end

    other_user = @potential_match.user_1 == current_user ? @potential_match.user_2 : @potential_match.user_1
    redirect_to root_path, notice: "You liked #{other_user.name}."
  end

  def decline
    @potential_match = find_or_create_potential_match

    @potential_match.update!(state: :declined)
    other_user = @potential_match.user_1 == current_user ? @potential_match.user_2 : @potential_match.user_1
    redirect_to root_path, notice: "You declined #{other_user.name}."
  end

  private

  def find_or_create_potential_match
    user_without_potential_match = User
      .where.not(id: current_user.id)
      .where.not(
        id: PotentialMatch.select(:user_1_id)
      )
      .where.not(
        id: PotentialMatch.select(:user_2_id)
      )
      .first

    if user_without_potential_match
      return PotentialMatch.create!(
        user_1: current_user,
        user_2: user_without_potential_match,
        state: "potential"
      )
    end

    PotentialMatch
      .where(match_id: nil)
      .where.not(state: ["declined", "matched"])
      .where("user_1_id = :id OR user_2_id = :id", id: current_user.id)
      .where("liked_by_id IS NULL OR liked_by_id != :id", id: current_user.id)
      .first
  end
end