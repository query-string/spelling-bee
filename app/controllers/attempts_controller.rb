class AttemptsController < ApplicationController
  def new
    @levels = Proficiency::LEVELS

    words = list.words.send(current_person.proficiency_level, current_person)
    words = list.words.random(current_person) if words.empty?
    @word = words.sample
    @definitions = @word.definitions
  end

  def create
    current_person.update(proficiency_level: params[:proficiency_level])

    @correct_word = list.words.find(list_params[:word_id])
    @input_word   = list_params[:name].downcase.strip

    attempt = if @input_word == @correct_word.name.downcase
      { status: :success, message: "Good job #{current_person.nickname}, your spelling of the word «#{@correct_word.name}» is correct" }
    else
      { status: :fail, message: "Sorry #{current_person.nickname}, your splelling of the word «#{@correct_word.name}» is wrong. Try again later?" }
    end

    @correct_word.attempts.create(person_id: current_person.id, status: attempt[:status], input: @input_word)

    redirect_to list_path(list), flash: { notice: attempt[:message] }
  end

  private

  def list_params
    params.require(:list).permit(:name, :word_id)
  end

  def list
    @list = List.find(params[:list_id])
  end
end
