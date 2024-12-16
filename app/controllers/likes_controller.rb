class LikesController < ApplicationController
  before_action :set_capsule

  def update
    like = @capsule.likes.find_or_initialize_by(user: current_user)

    if like.persisted?
      like.destroy

    else
      like.like = true # Marque comme un like
      like.save
    end


  end

  private

  def set_capsule
    @capsule = Capsule.find(params[:capsule_id])
  end


end
