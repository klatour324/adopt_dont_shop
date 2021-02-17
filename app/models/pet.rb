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
    where("name LIKE?", "%#{input[:pet_name]}%")
  end

  def self.find_by_name(name)
    where("lower(name) like ?", "%#{name.downcase}%")
  end

  def adoptable?
    return true if applications.where(application_status: "Approved").count >= 1

    self.update(adoptable: false)
  end
end
