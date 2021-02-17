require "rails_helper"

RSpec.describe "Admin Shelter Show Page" do
  before :each do
    @shelter_1 = create(:shelter, name: "Paws Chicago")
    @shelter_2 = create(:shelter, name: "Sunshine Shelter")
    @shelter_3 = create(:shelter, name: "Mackinac Shelter")
    @shelter_4 = create(:shelter, name: "Amazing Shelter")
  end
  it "shows the shelter's name and full address" do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end
end
