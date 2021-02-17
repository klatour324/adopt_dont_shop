require "rails_helper"

RSpec.describe "Admin Shelters Index Page" do
  before :each do
    @shelter_1 = create(:shelter, name: "Paws Chicago")
    @shelter_2 = create(:shelter, name: "Sunshine Shelter")
    @shelter_3 = create(:shelter, name: "Mackinac Shelter")
    @shelter_4 = create(:shelter, name: "Amazing Shelter")
  end
  it "can show each shelter in reverse alphabetical order by name" do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_1.name)
    expect(@shelter_1.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_4.name)
    expect(@shelter_1.name).to appear_before(@shelter_4.name)
  end
end
