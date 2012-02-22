class MainController < ApplicationController
  def index
    @latest_sermon = Sermon.where("services.name = ?", selected_service).order("date DESC").limit(1)
  end

end
