class TransactionsController  < ApplicationController

  def new
   if current_user
   @transaction = Transaction.new
   @user = current_user
   @to_accounts = User.find_all_by_is_activated(1).collect{ |u| [u.id, u.account_id]}
   else
     redirect_to "/login"
   end

  end

  def create
    @from_user = User.find_by_id(params[:user_id])
    @to_user = User.find_by_account_id(params[:to_account])
    transaction_id = SecureRandom.hex(6)
    otp_valid = @to_user.authenticate_otp("#{params[:otp]}", :drift=> 3000)
     puts "aaa"+@to_user.account_id.to_s
    puts  @from_user.wallet_amount > params[:amount].to_i
    if otp_valid and @from_user.wallet_amount.to_i > params[:amount].to_i
      Transaction.create(:account_id=>@from_user.account_id,:user_id=>@from_user.id, :transaction_id=>transaction_id,:amount=>params[:amount].to_i, :type=>"debit",:status=>"initiated")
      Transaction.create(:account_id=>@to_user.account_id,:user_id=>@to_user.id, :transaction_id=>transaction_id,:amount=>params[:amount].to_i, :type=>"credit", :status=>"initiated")
    else
      flash[:transaction_error] = "Transaction Failed"
      redirect_to "/transactions/new"
    end
  end

  def generate_otp
   user = User.find_by_account_id(params[:account_id])
   otp = user.otp_code
   msg_flag = send_msg(user.mobile,otp)
   puts "aaa"+msg_flag.to_s+otp.to_s
   render :json => {:msg_sent=>msg_flag, :otp=> otp}
  end

  def send_msg(mobile,otp)
    #begin
      account_sid = 'AC8f744a55287db6e30e33f8d6afa15f7d'
      auth_token = '04c44f660caed245e1755a7cdbe98add'
      @client = Twilio::REST::Client.new account_sid, auth_token
      puts "aaa"+mobile.to_s
      sent = @client.account.messages.create({ :from => '+19287560182', :to=> "+91#{mobile}", :body=>"Your OTP is #{otp}" })
      sent_sms = sent.present? ? "success" : "failed"
    #rescue
    #  sent_sms = "failed"
    #end
    sent_sms
  end

  def show

  end

  def index

  end

end