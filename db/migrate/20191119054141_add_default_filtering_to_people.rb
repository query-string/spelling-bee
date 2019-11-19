class AddDefaultFilteringToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :proficiency_level, :string, default: :random
  end
end
