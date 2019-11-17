class Word < ApplicationRecord
  belongs_to :list
  has_many :attempts
end
