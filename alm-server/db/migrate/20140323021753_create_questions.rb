class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :device
      t.integer :question
      t.string :answer

      t.timestamps
    end
    add_index :questions, [:device_id, :question]
  end
end
