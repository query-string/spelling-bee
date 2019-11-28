class My::WordsController < ApplicationController
  protect_from_forgery except: :update

  def index
    @person   = current_person
    @attempts = @person.attempts.for_today.by_fresh

    proficiency ||= @person.proficiencies.includes(:word)
    @positive = proficiency.positive.by_attempts
    @negative = proficiency.negative.by_attempts
    @neutral  = proficiency.neutral.by_attempts
  end

  def show
    @word = Word.find(params[:id])
    @attempts = @word.attempts.for_person(current_person).by_fresh
  end

  def update
    current_person.update(proficiency_level: params[:id])
    render plain: "OK"
  end
end
