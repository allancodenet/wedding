class RenameWeddingDateToEventDateInClient < ActiveRecord::Migration[7.0]
  def change
    rename_column :clients, :wedding_date, :event_date
  end
end
