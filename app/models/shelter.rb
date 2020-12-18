class Shelter < ApplicationRecord
  has_many :pets

  def formatted_address
    address + " " + city + ", " + state + " " + zip.to_s
  end

  def avg_age
    pets.where("adoptable = 'true'").average(:approximate_age)
  end

  def num_adoptable
    pets.where("adoptable = 'true'").count
  end

  def num_adopted
    pets.joins(:application_pets).where("status IS NOT NULL").count
  end

  def pending_pets
    pets.joins(:application_pets).where("status IS NULL")
  end

  def self.pending_shelters
    joins(pets: :application_pets).where("status IS NULL")
  end

end
