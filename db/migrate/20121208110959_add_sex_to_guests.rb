class AddSexToGuests < ActiveRecord::Migration
  def change
  	add_column :guests, :sex, :string
  end
end
