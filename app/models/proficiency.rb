class Proficiency < ApplicationRecord
  belongs_to :person
  belongs_to :word

  scope :for_person,  ->(person) { where(person_id: person.id) }
  scope :positive,    -> { where(level: :positive) }
  scope :negative,    -> { where(level: :negative) }
  scope :neutral,     -> { where(level: :neutral) }
  scope :by_attempts, -> { order("attempts_count desc") }
end
