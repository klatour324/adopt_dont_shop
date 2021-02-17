class Shelter < ApplicationRecord
  has_many :pets
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.order_in_reverse_alphabetical
    find_by_sql "SELECT * FROM shelters ORDER BY name DESC;"
  end

  def self.find_by_name_and_address
    find_by_sql "SELECT name, address, city, state, zip FROM shelters WHERE id=#{id};"
  end
end
