class CapsulesController < ApplicationController
  before_action :set_user_capsules

  def index
    @capsules = Capsule.all
    @markers = Capsule.geocoded.map do |capsule|
      {
        lat: capsule.latitude,
        lng: capsule.longitude,
        infoWindow: render_to_string(partial: "info_capsule", locals: { capsule: capsule }),
      }
    end
  end

  def new
    @capsule = Capsule.new
  end

  def create
    @capsule = Capsule.new(capsule_params)
    @capsule.user = current_user
    if @capsule.save
      redirect_to root_path(lat: @capsule.latitude, lng: @capsule.longitude, zoom: 12, openPopup: true)
    else
      render turbo_stream: turbo_stream.replace("capsule-form", partial: "capsules/form", locals: { capsule: @capsule })
    end
  end

  def set_user_capsules
    @user_capsules = current_user.capsules
  end

  private

  def capsule_params
    params.require(:capsule).permit(:title, :teasing, :category, :photo, :address, :audio_url)
  end
end
