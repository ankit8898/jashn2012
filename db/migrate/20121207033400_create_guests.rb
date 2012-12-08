class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.string :cell_num
      t.boolean :attending

      t.timestamps
    end
  end
end
