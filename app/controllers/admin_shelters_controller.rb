class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT name, id FROM Shelters ORDER BY name DESC")
    @pending_shelters = Shelter.pending_shelters.order(name: :desc)
  end

  def show
    #had to add id here because having no id would break all of the relations in the model
    @shelter = Shelter.find_by_sql("SELECT name, address, city, state, zip, id FROM Shelters WHERE id = '#{params[:id]}'").first
  end


end
