class ApplicationPetsController < ApplicationController
  def index
    @pets = ApplicationPet.find_by_name(params[:search])
  end

  def create
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    relation = ApplicationPet.create(pet: pet, application: application)
    redirect_to("/applications/#{params[:id]}")
  end

end
