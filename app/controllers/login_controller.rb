class LoginController < ApplicationController

  require 'rqrcode'

  def signup
    @user = User.new
  end

  def user_activation
    @user = User.find_by_id(params[:id])
    @qr = RQRCode::QRCode.new(@user.provisioning_uri, :size => 7, :level => :h )
  end

  def activate_user
    user = User.find_by_id(params[:user_id])
    user.is_activated=1
    user.save
    session[:user_id] = user.id
    redirect_to "/transactions/new"
  end


  def login
    @user = User.new
  end

  def signin
    user = User.find_by_email(params[:user][:email], :conditions=>["is_activated=1"])

    pwd_validate = user.authenticate("#{params[:user][:password]}")
    code_validate = user.authenticate_otp("#{params[:authentication_code]}")
    puts user.inspect
    puts pwd_validate.to_s
    puts code_validate.to_s
    if pwd_validate and code_validate
      session[:user_id] = user.id
      redirect_to "/transactions/new"
    else
      flash[:error] = "Authentication failed"
      redirect_to "/login"
    end
  end


end