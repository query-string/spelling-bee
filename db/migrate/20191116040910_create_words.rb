class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.integer :list_id, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
