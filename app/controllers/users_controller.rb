class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: "Profil mis à jour avec succès."
    else
      render :edit, alert: "Une erreur est survenue."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar)
  end

end
