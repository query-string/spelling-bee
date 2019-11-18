class Proficiency < ApplicationRecord
  belongs_to :person
  scope :for_person, ->(person) { where(person_id: person.id) }
end
