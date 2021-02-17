class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    pet_application = PetApplication.find(params[:pet_application_id])
    pet_application.update(pet_application_params)

    redirect_to "/admin/applications/#{params[:id]}"
  end

  private
  def pet_application_params
    params.permit(:status)
  end
end
