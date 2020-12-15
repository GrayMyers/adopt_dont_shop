require "rails_helper"
describe Application, type: :model do
  describe "relationships" do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe "instance methods" do
    before :each do
      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

      @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
      @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
      @pet4 = @shelter1.pets.create!(image:"", name: "Zeus 2", description: "dog", approximate_age: 4, sex: "male")

      @application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "Somewhere")
      @application2 = Application.create(applicant: "Jane Doe", description: "I love dogs more than John", address: "Somewhere")
    end

    it "determines whether application has pets" do
      expect(@application1.has_pets?).to eq(false)

      ApplicationPet.create(application: @application1, pet: @pet1)

      expect(@application1.has_pets?).to eq(true)
    end

    it "determines whether application has been submitted" do
      expect(@application1.submitted?).to eq(false)

      @application1.status = "Pending"
      @application1.save

      expect(@application1.submitted?).to eq(true)
    end
  end

end
