class BoostsController < ApplicationController
  before_action :set_bubble

  def new
    @boost = @bubble.boosts.build
  end

  def create
    @boost = @bubble.boosts.new
    @boost.save

    respond_to do |format|
      format.turbo_stream { render }
      format.html { head :no_content }
    end
  end

  def index
    @boosts = @bubble.boosts
  end

  private
    def set_bubble
      @bubble = Bubble.find(params[:bubble_id])
    end
end
