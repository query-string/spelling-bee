class Word < ApplicationRecord
  belongs_to :list
  has_many :attempts
  has_many :proficiencies

  scope :random,   ->(person) { minimal_attempts person }
  scope :positive, ->(person) { where("id in (?)", person.proficiencies.positive.pluck(:word_id)) }
  scope :neutral,  ->(person) { where("id in (?)", person.proficiencies.neutral.pluck(:word_id)) }
  scope :negative, ->(person) { where("id in (?)", person.proficiencies.negative.pluck(:word_id)) }

  scope :minimal_attempts, ->(person) {
    proficiency     = Proficiency.for_person(person)
    attempted_words = proficiency.where(attempts_count: proficiency.minimum(:attempts_count))
    where(id: attempted_words.pluck(:word_id))
  }

  def definitions
    url = "https://www.dictionaryapi.com/api/v3/references/sd4/json/#{name}?key=#{ENV['DICTIONARY_API_KEY']}"
    response = HTTParty.get(url)
    response.parsed_response[0]["shortdef"]
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
