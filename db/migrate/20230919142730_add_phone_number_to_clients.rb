class AddPhoneNumberToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :phone_number, :bigint
  end
end
