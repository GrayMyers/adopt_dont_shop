class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_by_name(search)
    search ||= ""
    Pet.where("lower(name) like ?", "%#{search.downcase}%")
  end
end
