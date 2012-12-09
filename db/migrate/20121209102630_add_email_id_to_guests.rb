class AddEmailIdToGuests < ActiveRecord::Migration
  def change
  	add_column :guests, :email_id, :string
  end
end
