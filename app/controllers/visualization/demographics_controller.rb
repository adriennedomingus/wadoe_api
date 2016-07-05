class Visualization::DemographicsController < ApplicationController
  def index
    @districts = District.all
  end
end
