class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :auth
  def pay
    console
    @provider = Provider.find params[:id]
    transactions = PaystackTransactions.new(@pay_stack_obj)
    callback = "https://kenyaserviceproviders.com#{callback_provider_path(@provider)}"
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
      callback_url: callback
    )
    auth_url = response["data"]["authorization_url"]
    redirect_to auth_url, allow_other_host: true
  end

  def callback
    @provider = Provider.find params[:id]
    transaction_reference = params[:reference]
    transactions = PaystackTransactions.new(@pay_stack_obj)
    response = transactions.verify(transaction_reference)
    if response["data"]["status"] == "success"
      @provider.update!(published_at: Time.now)
      redirect_to providers_path, notice: "payment successful #{@provider.name} has been published"
    else
      redirect_to providers_path, danger: "payment failed contact us for help"
    end
  end

  def auth
    @public_key = ENV["PAYSTACK_PUBLIC_KEY"]
    @secret_key = ENV["PAYSTACK_SECRET_KEY"]
    @pay_stack_obj = Paystack.new(@public_key, @secret_key)
  end
end
