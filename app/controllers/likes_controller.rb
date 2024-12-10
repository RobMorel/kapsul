class LikesController < ApplicationController

  def like
    like = @capsule.likes.find_by(user: current_user)
    if like
      like.destroy
    else
      @capsule.likes.create(user: current_user)
    end

  end
end
