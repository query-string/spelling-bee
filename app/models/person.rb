class Person < ApplicationRecord
  has_many :attempts
  has_many :proficiencies
end
