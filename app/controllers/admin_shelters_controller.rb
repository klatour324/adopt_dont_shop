class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse_alphabetical
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
