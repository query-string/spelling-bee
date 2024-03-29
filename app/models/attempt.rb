class Attempt < ApplicationRecord
  belongs_to :person
  belongs_to :word

  scope :date_groupped, -> { group_by { |a| a.created_at.beginning_of_day }.reverse_each }
  scope :for_today,     -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  scope :for_person,    ->(person) { where(person_id: person.id) }
  scope :success,       -> { where(status: :success) }
  scope :fail,          -> { where(status: :fail) }
  scope :by_fresh,      -> { order("id desc") }

  after_save :update_proficiency

  def update_proficiency
    word.update_proficiency_of(person)
  end

  def compare
    expectation = word.name.downcase
    answer      = input.downcase
    expectation.chars.map.with_index do |letter, index|
      {
        expectation: letter,
        answer: answer[index],
        state: letter == answer[index]
      }
    end
  end
end
