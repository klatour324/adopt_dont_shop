class Shelter < ApplicationRecord
  has_many :pets
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.order_in_reverse_alphabetical
    find_by_sql "select * from shelters order by name desc;"
  end
end
