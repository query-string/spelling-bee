class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @word = list.words.sample
  end

  def update
    @correct_word = list.words.find(list_params[:word_id])
    @input_word   = list_params[:name]

    attempt = if @input_word.downcase == @correct_word.name.downcase
      { status: :success, message: "Good job #{current_person.nickname}, your spelling of the word «#{@correct_word.name}» is correct" }
    else
      { status: :fail, message: "Sorry #{current_person.nickname}, your splelling of the word «#{@correct_word.name}» is wrong. Try again later?" }
    end

    p @correct_word.attempts.create(person_id: current_person.id, status: attempt[:status], input: @input_word)

    redirect_to list_path(list), flash: { notice: attempt[:message] }
  end

  private

  def list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :word_id)
  end
end
