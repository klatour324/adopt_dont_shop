require "rails_helper"

RSpec.describe "Admin Application Show Page" do
  before :each do
    PetApplication.destroy_all
    Pet.destroy_all
    Shelter.destroy_all
    Application.destroy_all

    @shelter = create(:shelter)
    @pet_1 = @shelter.pets.create!(name: 'Kiko',
                                 approximate_age: 10,
                                 description: "Happy pup",
                                 sex: 1)
    @pet_2 = @shelter.pets.create!(name: 'Nikita',
                                 approximate_age: 2,
                                 description: "Very happy pup",
                                 sex: 0)
    @pet_3 = @shelter.pets.create!(name: 'Kasha',
                                 approximate_age: 4,
                                 description: "Very happy pup",
                                 sex: 0)
    @pet_4 = @shelter.pets.create!(name: 'Bella',
                                 approximate_age: 5,
                                 description: "Very happy pup",
                                 sex: 0)
    @application = create(:application)
    @application.pets << [@pet_1, @pet_2]

    # @shelter_1 = create(:shelter, id: 1)
    # @pet_1 = create(:pet, id: 1, shelter_id: 1, name: "Nikita")
    # @pet_2 = create(:pet, id: 2, shelter_id: 1, name: "Kiko")
    # @application = create(:application, id: 1, application_status: "Pending")
    # @pet_application_1 = create(:pet_application, application_id: 1, pet_id: 1 )
    # @pet_application_2 = create(:pet_application, application_id: 1, pet_id: 2 )
  end

  it "can approve a pet for adoption" do
    visit "/admin/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_button("Approve")

      click_button("Approve")

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to_not have_button("Approve")
      expect(page).to have_content("Pet Approved")
    end

    within "#pet-#{@pet_2.id}" do
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Approve")
      click_button("Approve")

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to_not have_button("Approve")
      expect(page).to have_content("Pet Approved")
    end
  end

  # it "can reject a pet for adoption" do
  #   visit "/admin/applications/#{@application.id}"
  #
  #   within "#pet-#{@pet_1.id}" do
  #     expect(page).to have_content(@pet_1.name)
  #     expect(page).to have_button("Reject")
  #
  #     click_button("Reject")
  #
  #     expect(current_path).to eq("/admin/applications/#{@application.id}")
  #     expect(page).to_not have_button("Approve")
  #     expect(page).to_not have_button("Rejcet")
  #     expect(page).to have_content("Pet Rejected")
  #   end
  #
  #   within "#pet-#{@pet_2.id}" do
  #     expect(page).to have_content(@pet_2.name)
  #     expect(page).to have_button("Reject")
  #     click_button("Reject")
  #
  #
  #     expect(current_path).to eq("/admin/applications/#{@application.id}")
  #     expect(page).to_not have_button("Approve")
  #     expect(page).to_not have_button("Reject")
  #     expect(page).to have_content("Pet Rejected")
  #   end
  # end
end
