class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :auth
  def pay
    @provider = Provider.find params[:id]
    transactions = PaystackTransactions.new(@pay_stack_obj)
    callback = "http://127.0.0.1:3000#{callback_provider_path(@provider)}"
    # Customize your payment details here
    amount = 50000
    email = current_user.email # Replace with the customer's email
    reference = SecureRandom.hex(8)
    currency = "KES"
    response = transactions.initializeTransaction(
      reference: reference,
      amount: amount,
      email: email,
      currency: currency,
      callback: callback
    )
    auth_url = response["data"]["authorization_url"]
    redirect_to auth_url, allow_other_host: true
  end

  def callback

    # transaction_reference = "blablablabla-YOUR-VALID-UNIQUE-REFERENCE-HERE"
	  # transactions = PaystackTransactions.new(paystackObj)
	  # result = transactions.verify(transaction_reference) 
  
  end

  def auth
    @public_key = ENV["PAYSTACK_PUBLIC_KEY"]
    @secret_key = ENV["PAYSTACK_SECRET_KEY"]
    @pay_stack_obj = Paystack.new(@public_key, @secret_key)
  end
end
