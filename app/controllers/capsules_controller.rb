class CapsulesController < ApplicationController
before_action :set_capsule, only: [:show]


#bande de loser dans cette methode je recupère la liste de toutes les capsules et un hash de leurs coordonnées

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
      redirect_to capsule_path(@capsule), notice: "Capsule created successfully!"
    else
      render turbo_stream: turbo_stream.replace("capsule-form", partial: "capsules/form", locals: { capsule: @capsule })
    end
  end

  def show
  end

  private

  def set_capsule
    @capsule = Capsule.find(params[:id])
  end

  def capsule_params
    params.require(:capsule).permit(:audio, :title, :teasing, :category, :image, :address)
  end
end
