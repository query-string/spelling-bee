class RecalculateProficiencies < ActiveRecord::Migration[6.0]
  def change
    words ||= Word.all

    Person.all.each do |person|
      words.each do |word|
        word.update_proficiency_of person
      end
    end
  end
end
