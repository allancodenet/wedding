class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def pay
    public_key = ENV["PAYSTACK_PUBLIC_KEY"]
    secret_key = ENV["PAYSTACK_SECRET_KEY"]
    @provider = Provider.find params[:id]
    paystackObj = Paystack.new(public_key, secret_key)
    transactions = PaystackTransactions.new(paystackObj)
    # Customize your payment details here
    amount = 50000
    email = current_user.email # Replace with the customer's email
    reference = SecureRandom.hex(8)
    currency = "KES"
    result = transactions.initializeTransaction(
      reference: reference,
      amount: amount,
      email: email,
      currency: currency
    )
    auth_url = result["data"]["authorization_url"]
    redirect_to auth_url, allow_other_host: true
  end
end
