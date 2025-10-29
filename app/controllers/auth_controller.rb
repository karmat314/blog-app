class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  # Render signup form
  def new_register
  end

  # Render login form
  def new_login
  end

  # POST /register
  def register
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      # Store token in session to use in UI
      session[:jwt] = token
      redirect_to posts_path, notice: "Registered successfully!"
    else
      flash[:alert] = user.errors.full_messages.join(", ")
      redirect_to signup_path
    end
  end

  # POST /login
  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      session[:jwt] = token
      redirect_to posts_path, notice: "Logged in successfully!"
    else
      flash[:alert] = "Invalid username or password"
      redirect_to login_page_path
    end
  end

  def logout
    session[:jwt] = nil
    redirect_to login_page_path, notice: "Logged out successfully!"
  end
  
  private

  def user_params
    params.permit(:username, :password)
  end
end
