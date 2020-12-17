class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_length_of :description, minimum:1 , on: :update

  def has_pets?
    !pets.empty?
  end

  def submitted?
    submitted
  end

  def formatted_address
    address + " " + city + ", " + state + " " + zip
  end

  def check_status
    if submitted?
      final_result = "Approved"
      pets.each do |pet|
        result = pet.application_result(id)
        if result == "Rejected"
          final_result = "Rejected"
        elsif !result #no action has been taken
          final_result = "Pending"
          break
        end
      end
      final_result
    else 
      "Not Submitted"
    end
  end
end
