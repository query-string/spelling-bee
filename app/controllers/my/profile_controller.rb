class My::ProfileController < ApplicationController
  def index
    @person   = current_person
    @attempts = @person.attempts

    proficiency ||= @person.proficiencies
    @positive = proficiency.positive.by_attempts
    @negative = proficiency.negative.by_attempts
    @neutral  = proficiency.neutral.by_attempts
  end
end
