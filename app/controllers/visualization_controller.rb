class VisualizationController < ApplicationController

  def index
    @districts = District.all
  end
end
