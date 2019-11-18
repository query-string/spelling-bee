class Attempt < ApplicationRecord
  belongs_to :person
  belongs_to :word

  scope :date_groupped, -> { group_by { |a| a.created_at.beginning_of_day }.reverse_each }
  scope :success,       -> { where(status: :success) }
  scope :fail,          -> { where(status: :fail) }
end
