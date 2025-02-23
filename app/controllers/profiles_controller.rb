# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in

  # Show profile page
  def show
    @user = current_user
  end

  # Edit profile page
  def edit
    @user = current_user
  end

  # Update profile
  def update
    @user = current_user

    if @user.update(profile_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :profile_picture)
  end
end
