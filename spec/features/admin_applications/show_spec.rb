require "rails_helper"

RSpec.describe "Admin Application Show Page" do
  before :each do
    @pet_1 = create(:pet)
    @pet_2 = create(:pet, name: "Bella")
    @pet_3 = create(:pet, name: "Kiko")

    @application = create(:application)
    @application.pets << [@pet_1, @pet_2]

    @application_2 = create(:application, application_status: "Pending")
    @application_2.pets << [@pet_1]
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

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to_not have_button("Approve")
    expect(page).to have_content("Pet Approved")
  end

  it "can reject a pet for adoption" do
    visit "/admin/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_button("Reject")

      click_button("Reject")

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to_not have_button("Approve")
      expect(page).to_not have_button("Rejcet")
      expect(page).to have_content("Pet Rejected")
    end

    within "#pet-#{@pet_2.id}" do
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Reject")

      click_button("Reject")

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to_not have_button("Approve")
      expect(page).to_not have_button("Reject")
      expect(page).to have_content("Pet Rejected")
    end
  end

  it "can approve/reject pets on one application without affecting other applications" do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_button("Approve")

      click_button("Approve")

      expect(page).to have_content("Pet Approved")
      expect(page).to_not have_button("Reject")
      expect(page).to_not have_content("Pet Rejected")
    end

    visit "/admin/applications/#{@application_2.id}"

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to_not have_content("Pet Approved")
    expect(page).to_not have_content("Pet Rejected")
    expect(page).to have_button("Reject")
  end

  it "can approve all the pets on an application" do
    visit "/admin/applications/#{@application.id}"

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_2.name}")
    expect(page).to have_button("Approve")

    click_button("Approve", match: :first)

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to have_content("Approved")
  end

  it "can reject one or more pets on an application" do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_button("Reject")
      expect(page).to have_button("Approve")

      click_button("Reject", match: :first)

      expect(page).to have_content("Pet Rejected")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_content("#{@pet_2.name}")
      expect(page).to have_button("Reject")
      expect(page).to have_button("Approve")

      click_button("Approve", match: :first)

      expect(page).to have_content("#{@pet_2.name}")
      expect(page).to have_content("Pet Approved")
    end

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to have_content("Rejected")
  end

  it "can make pets unadoptable once application is approved" do
    visit "/admin/applications/#{@application.id}"


    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Approve")

      click_button("Approve", match: :first)
    end

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content("No Longer Adoptable")

    visit "/admin/applications/#{@application.id}"
  end

  it "can only have one approved and pending application on them at any time" do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@pet_1.id}") do
      click_button("Approve")
    end

    visit "/admin/applications/#{@application_2.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_content("Pet already approved for adoption")
      expect(page).to have_button("Reject")
    end
  end
end
