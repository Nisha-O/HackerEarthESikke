class UsersController < ApplicationController

  def create
    params[:user][:account_id] = Random.rand(1000...9999)
    params[:user][:wallet_amount]=10000
    @user = User.create(params[:user])
    err = @user.errors.full_messages.join(",")
    puts "@user.errors"+err
    puts "aaa"+@user.id.to_s
    if @user.id
      redirect_to "/user_activation/#{@user.id}"

    else
      flash[:signup_error] = err
      redirect_to "/signup"
    end


  end

end