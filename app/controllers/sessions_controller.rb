class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      log_in(@user)
      redirect_to subs_url
    else
      flash[:errors] = ["your user sucks"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to subs_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
