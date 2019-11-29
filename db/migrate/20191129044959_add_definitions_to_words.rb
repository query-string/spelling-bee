class AddDefinitionsToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :definitions, :text, array: true, default: []
  end
end
