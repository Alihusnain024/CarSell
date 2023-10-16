class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    email = params[:email]
    password = params[:password]
    user = User.find_by(email: email)
    if user && user.valid_password?(password)
      render json: { token: JsonWebToken.encode(user_id: user.id) }
    else
      render json: { errors: ["Invalid email or password"] }, status: :unauthorized
    end
  end

  def destroy
    session.delete(current_user.id)
    sign_out(current_user)
    render :json => { :message => 'Sign out Successfully.' }, :status => 200
  end
end