class AddPhoneNumberToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :phone_number, :bigint
  end
end
