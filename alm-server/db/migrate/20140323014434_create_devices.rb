class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :device_id, null: false, index: true
      t.integer :major_id
      t.string :device_token

      t.timestamps
    end
  end
end
