class Visualization::GraduationController < ApplicationController
  def index
    @districts = District.all
  end
end
