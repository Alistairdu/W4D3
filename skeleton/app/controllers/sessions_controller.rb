class SessionsController < ApplicationController 
  
  def new 
    @user = User.new 
    render :new 
  end 

  def create  
     user = User.find_by_credentials(
          params[:user][:user_name],
          params[:user][:password]
        )
    if user 
      session[:session_token] = user.reset_session_token! 
      redirect_to cats_url
    else  
      flash.now[:errors] = ['invalid user_name or password']
      render :new 
    end    
  end 

  def destroy 
    user = current_user
    user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

end