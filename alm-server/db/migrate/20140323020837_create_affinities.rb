class CreateAffinities < ActiveRecord::Migration
  def change
    create_table :affinities do |t|
      t.integer :from_device_id, null: false
      t.integer :to_device_id, null: false
      t.integer :level, null: false, default: 0

      t.timestamps
    end
  end
end
