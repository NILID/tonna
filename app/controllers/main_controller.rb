class MainController < ApplicationController
  def index
    @last_projects = Project.where(hide: false).order(created_at: :desc).limit(3).includes(:taggings)
  end
end
