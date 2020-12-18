require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it {should have_many :application_pets}
    it { should have_many(:applications).through(:application_pets) }
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  describe "instance methods" do
    before :each do
      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

      @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
      @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

      @application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80129")
      @application2 = Application.create(applicant: "Jane Doe", description: "I love dogs more than John", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80129")
      @application3 = Application.create(applicant: "Jane Doe", description: "I love dogs more than John", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80129")


      @pet_1_app_1 = ApplicationPet.create(application: @application1, pet: @pet1)
      @pet_1_app_1.status = "Approved"
      @pet_1_app_1.save
    end

    it "application_result" do
      expect(@pet1.application_result(@application1.id)).to eq(@pet_1_app_1.status)
    end

    it "pending_apps" do
      pet_1_app_2 = ApplicationPet.create(application: @application2, pet: @pet1)
      pet_1_app_3 = ApplicationPet.create(application: @application3, pet: @pet1)
      expect(@pet1.pending_apps).to eq([pet_1_app_2,pet_1_app_3])
    end
  end
end
