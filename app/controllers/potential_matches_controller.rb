class PotentialMatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @potential_match = find_or_create_potential_match
  end

  def like
    @potential_match = PotentialMatch.find(params[:id])
    other_user = @potential_match.user_1 == current_user ? @potential_match.user_2 : @potential_match.user_1

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
        return redirect_to root_path, notice: "You matched with #{other_user.name}!"
      end
    elsif @potential_match.potential?
      @potential_match.update!(
        state: :liked,
        liked_by: current_user
      )
    else
      return redirect_to root_path, alert: "This match can no longer be updated."
    end

    redirect_to root_path, notice: "You liked #{other_user.name}."
  end

  def decline
    @potential_match = PotentialMatch.find(params[:id])

    @potential_match.update!(state: :declined)
    other_user = @potential_match.user_1 == current_user ? @potential_match.user_2 : @potential_match.user_1
    redirect_to root_path, notice: "You declined #{other_user.name}."
  end

  private

  def find_or_create_potential_match
    existing_potential_match = PotentialMatch
      .where(match_id: nil)
      .where.not(state: ["declined", "matched"])
      .where("user_1_id = :id OR user_2_id = :id", id: current_user.id)
      .where("liked_by_id IS NULL OR liked_by_id != :id", id: current_user.id)
      .order(created_at: :asc)
      .first

    return existing_potential_match if existing_potential_match.present?

    seen_user_ids = PotentialMatch
      .where("user_1_id = :id OR user_2_id = :id", id: current_user.id)
      .pluck(:user_1_id, :user_2_id)
      .flatten
      .uniq

    user = User
      .where.not(id: current_user.id)
      .where.not(id: seen_user_ids)
      .order(created_at: :asc)
      .first

    return nil unless user.present?

    PotentialMatch.create!(
      user_1: current_user,
      user_2: user,
      state: "potential"
    )
  end
end