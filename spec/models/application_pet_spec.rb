describe ApplicationPet, type: :model do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "class methods" do
    before :each do
      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

      @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
      @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
      @pet4 = @shelter1.pets.create!(image:"", name: "Zeus 2", description: "dog", approximate_age: 4, sex: "male")


      @application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "Somewhere")
      @application2 = Application.create(applicant: "Jane Doe", description: "I love dogs more than John", address: "Somewhere")

      ApplicationPet.create(application: @application1, pet: @pet1)
      ApplicationPet.create(application: @application1, pet: @pet2)
    end

    it "can find pets by name" do
      pets = ApplicationPet.find_by_name("zeus")
      expect(pets).to include(@pet3)
      expect(pets).to include(@pet4)
    end
  end
end
