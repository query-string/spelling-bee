class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.integer :word_id, null: false
      t.integer :person_id, null: false
      t.string :status, null: false
      t.string :input, null: false

      t.timestamps
    end
  end
end
