class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.following << @user unless current_user.following?(@user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referer || root_path, notice: "Agora você está seguindo #{@user.name}!" }
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.following.delete(@user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referer || root_path, notice: "Você deixou de seguir #{@user.name}." }
    end
  end
end