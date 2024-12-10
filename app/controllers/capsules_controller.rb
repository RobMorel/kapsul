class CapsulesController < ApplicationController
  before_action :set_capsule, only: [:show]

  def index
    @capsules = Capsule.all
  end

  def show

  end

  private

  def set_capsule
    @capsule = Capsule.find(params[:id])
  end
end
