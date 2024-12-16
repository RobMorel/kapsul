class CapsulesController < ApplicationController
  before_action :set_user_capsules

  def index
    # We show the capsules depending their category. If no filter selected, we show all
    if params[:category].present? && params[:category] != "all"
      @capsules = Capsule.where(category: params[:category])
    else
      @capsules = Capsule.all
    end

    @markers = @capsules.geocoded.map do |capsule|
      {
        lat: capsule.latitude,
        lng: capsule.longitude,
        infoWindow: render_to_string(partial: "info_capsule", formats: [:html], locals: { capsule: capsule }),
        marker_html: render_to_string(partial: "marker", formats: [:html], locals: { capsule: capsule})
      }
    end

    respond_to do |format|
      format.html
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.replace("map", partial: "map", locals: { markers: @markers }),
          turbo_stream.replace("capsules_list", partial: "capsules_list", locals: { capsules: @capsules })
        ]
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
      redirect_to root_path(format: :html, lat: @capsule.latitude, lng: @capsule.longitude, zoom: 12, openPopup: true), status: :see_other
      # redirect_to root_path(lat: @capsule.latitude, lng: @capsule.longitude, zoom: 12, openPopup: true), status: :see_other
    else
      render turbo_stream: turbo_stream.replace("capsule-form", partial: "capsules/form", locals: { capsule: @capsule })
    end
  end

  private

  def set_user_capsules
    @user_capsules = current_user.capsules
  end

  def capsule_params
    params.require(:capsule).permit(:title, :teasing, :category, :photo, :address, :audio_url)
  end
end
