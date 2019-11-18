class CreateProficiencies < ActiveRecord::Migration[6.0]
  def change
    create_table :proficiencies do |t|
      t.integer :person_id, null: false
      t.integer :word_id, nill: false
      t.string :level, default: "neutral"
      t.integer :attempts_count, default: 0

      t.timestamps
    end
  end
end
