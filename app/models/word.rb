class Word < ApplicationRecord
  belongs_to :list
  has_many :attempts
  has_many :proficiencies

  def calculate_level_of(person)
    attempts ||= person.attempts.where(word_id: id)
    { attempts: attempts.count, success: attempts.success.count, fail: attempts.fail.count }
  end

  def update_proficiency_of(person)
    level       = calculate_level_of person
    proficiency = proficiencies.for_person(person).first_or_create
    proficiency.update(level: get_level(level), attempts_count: level[:attempts])
  end

  private

  def get_level(level)
    if level[:success] > level[:fail]
      :positive
    elsif level[:fail] > level[:success]
      :negative
    else
      :neutral
    end
  end
end
