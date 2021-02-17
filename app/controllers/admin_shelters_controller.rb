class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse_alphabetical
  end
end
