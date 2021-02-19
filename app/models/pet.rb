class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name, :description, :approximate_age, :sex
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.pet_name(input)
    where("name ILIKE?", "%#{input[:pet_name]}%")
  end

  def self.find_by_name(name)
    where("lower(name) like ?", "%#{name.downcase}%")
  end

  def adoption_status
    if adoptable == false
      "No Longer Adoptable"
    else
      "Adoptable"
    end
  end
  
  def application_already_approved?
    applications.any? do |application|
      application.application_status == "Approved"
    end
  end
end
