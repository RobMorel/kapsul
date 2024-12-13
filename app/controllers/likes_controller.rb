class LikesController < ApplicationController
  before_action :set_capsule

 def create
  @like = @capsule.likes.new
  if @like.save
    render json: { count: @capsule.likes.count }, status: :created
  else
    render json: @like.errors, status: :unprocessable_entity
  end
 end

 def destroy
  @like = @capsule.likes.last
  @like&.destroy
  render json: { count: @capsule.likes.count }, status: :ok
 end

  private

  def set_capsule
    @capsule = Capsule.find(params[:capsule_id])
  end


end
