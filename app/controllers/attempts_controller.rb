class AttemptsController < ApplicationController
  before_action :fetch_list

  def new
    @levels = Proficiency::LEVELS

    words = @list.words.send(current_person.proficiency_level, current_person)
    words = @list.words.random(current_person) if words.empty?
    @word = words.sample
    @definitions = @word.fetch_definitions
  end

  def create
    @correct_word = @list.words.find(list_params[:word_id])
    @input_word   = list_params[:name].downcase.strip

    result = if @input_word == @correct_word.name.downcase
      { status: :success, message: "Good job #{current_person.nickname}, your spelling of the word «#{@correct_word.name}» is correct" }
    else
      { status: :fail, message: "Sorry #{current_person.nickname}, your splelling of the word «#{@correct_word.name}» is wrong. Try again later?" }
    end

    attempt = @correct_word.attempts.create(person_id: current_person.id, status: result[:status], input: @input_word)

    redirect_to list_attempt_path(@list, attempt), flash: { "#{result[:status] == :success ? :notice : :alert}" => result[:message] }
  end

  def show
    @attempt = Attempt.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name, :word_id)
  end

  def fetch_list
    @list ||= List.find(params[:list_id])
  end
end
