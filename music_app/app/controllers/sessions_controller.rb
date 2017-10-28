class SessionsController < ApplicationController

  def new
    render :new
  end


  def create
    @user = User.find_by_credentials(session_params[:email], session_params[:password])
    if @user

      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid login"]
      render :new
    end
  end

  def destroy
    if current_user
      log_out!(current_user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Must login to logout"]
      render :new
    end
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
