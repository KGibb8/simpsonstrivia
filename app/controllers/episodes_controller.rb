class EpisodesController < ApplicationController
  before_action :find_episode, only: [:show]

  def show
  end

  private

  def find_episode
    @episode = Episode.find(params[:id])
  end
end
