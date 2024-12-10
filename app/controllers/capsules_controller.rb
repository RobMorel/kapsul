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

  def show
  end

  private

  def set_capsule
      @capsule = Capsule.find(params[:id])
  end
end
