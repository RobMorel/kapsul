class LikesController < ApplicationController
  before_action :find_capsule, only: :create


  def destroy
    like = Like.find(params[:id])
    like.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:button_like,
          partial: "capsules/button_like",
          locals: { like: nil, capsule: like.capsule })
      end
      format.html { redirect_to root_path }
    end
  end

  def create
   like = @capsule.likes.create!(user: current_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:button_like,
          partial: "capsules/button_like",
          locals: { like: like, capsule: @capsule })
      end
      format.html { redirect_to root_path }
    end
  end

  private

  def find_capsule
    @capsule = Capsule.find(params[:capsule_id])
  end

end
