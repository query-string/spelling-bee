class ApplicationController < ActionController::Base
  helper_method :current_person

  def current_person
    @current_person ||= Person.first
  end
end
