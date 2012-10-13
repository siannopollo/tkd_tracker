require 'school'

class EntryPageController < ApplicationController
  def index
    @schools = School.all
  end
end