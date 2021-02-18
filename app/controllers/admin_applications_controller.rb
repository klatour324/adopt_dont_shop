class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = PetApplication.find(params[:pet_application_id])
    pet_application.update(pet_application_params)

    if params[:status].downcase == "approved"
      pet_application.application.update(application_status: "Approved")
      pet_application.pet.update(adoptable: false)
    else
      pet_application.application.update(application_status: "Rejected")
    end

    redirect_to "/admin/applications/#{params[:id]}"
  end

  private
  def pet_application_params
    params.permit(:status)
  end
end
