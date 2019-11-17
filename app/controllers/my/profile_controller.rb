class My::ProfileController < ApplicationController
  def index
    @person   = current_person
    @attempts = @person.attempts
  end
end
