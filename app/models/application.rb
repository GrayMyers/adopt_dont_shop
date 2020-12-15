class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def has_pets?
    !pets.empty?
  end

  def submitted?
    !!status
  end
end
