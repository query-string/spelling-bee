class Word < ApplicationRecord
  belongs_to :list
  has_many :attempts
  has_many :proficiencies

  scope :random,   ->(person) { minimal_attempts_number person }
  scope :positive, ->(person) { minimal_attempts_number person, :positive }
  scope :neutral,  ->(person) { minimal_attempts_number person, :neutral }
  scope :negative, ->(person) { minimal_attempts_number person, :negative }

  scope :minimal_attempts_number, ->(person, scope = :all) {
    proficiency     = person.proficiencies.send(scope)
    attempted_words = proficiency.where(attempts_count: proficiency.minimum(:attempts_count))
    where(id: attempted_words.pluck(:word_id))
  }

  def definitions
    DinctionaryService.(name)
  end

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
