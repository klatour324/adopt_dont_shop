class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    pet_application = PetApplication.find(params[:pet_application_id])
    pet_application.update(pet_application_params)

    if @application.pet_applications.all? == "Approved"
      @application.update(application_status: "Approved")
    else
      @application.update(application_status: "Rejected")
    end
    @application.save
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private
  def pet_application_params
    params.permit(:status)
  end
end
