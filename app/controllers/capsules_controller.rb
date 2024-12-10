class CapsulesController < ApplicationController

#bande de loser dans cette methode je recupère la liste de toutes les capsules et un hash de leurs coordonnées

def index
    @capsules = Capsule.all
    @markers = Capsule.geocoded.map do |capsule|
      {
        lat: capsule.latitude,
        lng: capsule.longitude
      }
    end
  end

end
