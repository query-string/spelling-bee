class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name, empty: false
      t.string :nickname, empty: false

      t.timestamps
    end
  end
end
