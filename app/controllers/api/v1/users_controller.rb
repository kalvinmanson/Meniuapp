class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index

  end
  def autologin
    user = User.where(id: params[:id]).first
    if user
      token = Digest::SHA1.hexdigest(user.created_at.to_s)
      if token == params[:token]
        render json: user
      end
    end
  end
  def login
    user = User.where(email: params[:email]).first
    if user
      token = Digest::SHA1.hexdigest(user.created_at.to_s)
      if user.valid_password?(params[:password])
        render json: user
      end
    end
  end
  def register
    user = User.where(email: params[:email]).first
    if !user && !params[:password].blank? && params[:password] == params[:password_confirmation] && !params[:name].blank?
      user = User.create(:name => params[:name], :role => "App", :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
      token = Digest::SHA1.hexdigest(user.created_at.to_s)
      render json: user
    end
  end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:email).permit(:id, :name, :email, :password, :password_confirmation, :token)
    end
end
