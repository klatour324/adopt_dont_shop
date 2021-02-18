require "rails_helper"

RSpec.describe PetApplication, type: :model do
  before :each do
    PetApplication.destroy_all
    Pet.destroy_all
    Shelter.destroy_all
    Application.destroy_all

    # @shelter = create(:shelter)
    # @pet_1 = @shelter.pets.create!(name: 'Kiko',
    #                              approximate_age: 10,
    #                              description: "Happy pup",
    #                              sex: 1)
    # @pet_2 = @shelter.pets.create!(name: 'Nikita',
    #                              approximate_age: 2,
    #                              description: "Very happy pup",
    #                              sex: 0)
    # @pet_3 = @shelter.pets.create!(name: 'Kasha',
    #                              approximate_age: 4,
    #                              description: "Very happy pup",
    #                              sex: 0)
    # @pet_4 = @shelter.pets.create!(name: 'Bella',
    #                              approximate_age: 5,
    #                              description: "Very happy pup",
    #                              sex: 0)
    # @application = create(:application)
    # @application.pets << [@pet_1, @pet_2]
    @shelter_1 = create(:shelter, id: 1)
    @pet_1 = create(:pet, id: 1, shelter_id: 1, name: "Nikita")
    @pet_2 = create(:pet, id: 2, shelter_id: 1, name: "Kiko")
    @application = create(:application, id: 1)
    @pet_application = create(:pet_application, application_id: 1, pet_id: 1 )
  end

  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "validations" do
    it { should validate_presence_of :application_id }
    it { should validate_presence_of :pet_id }
  end

  it "can be nil to start" do

    expect(@pet_application.status).to eq(nil)
    expect(@pet_application.approved?).to eq(false)
    expect(@pet_application.rejected?).to eq(false)
  end


  it "can have an approved status" do
    @pet_application = create(:pet_application, application_id: 1, pet_id: 1, status: :approved )

    expect(@pet_application.status).to eq("approved")
    expect(@pet_application.approved?).to eq(true)
    expect(@pet_application.rejected?).to eq(false)
  end

  it "can have a rejected status" do
    @pet_application = create(:pet_application, application_id: 1, pet_id: 1, status: :rejected )

    expect(@pet_application.status).to eq("rejected")
    expect(@pet_application.approved?).to eq(false)
    expect(@pet_application.rejected?).to eq(true)
  end
end
