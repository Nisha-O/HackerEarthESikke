class HomeController < ApplicationController
  def index
    @welcome_msg = "It's Nice to Meet You"
    puts @current_user.inspect+"aaa"
    if @current_user.present? and @current_user.wallet_amount.to_i >0
      @welcome_msg =  "Wow ! You have #{@current_user.wallet_amount} in your Wallet !"
    end
  end

end
