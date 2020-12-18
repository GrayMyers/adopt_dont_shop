require "rails_helper"
describe "admin shelter index page" do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Funny Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter3 = Shelter.create!(name: "Singular Shelter", address: "1 Ave", city: "Denver", state: "CO", zip: 80011)

    visit "/admin/shelters/#{@shelter1.id}"
  end

  it "shows shelter name and full address" do
    expect(page).to have_content("Shady Shelter")
    expect(page).to have_content("123 Shady Ave Denver, CO 80011")
  end

  it "has a statistics section containing average pet age, count of adoptable pets, and count of pets that have been adopted" do
    shelter = Shelter.create(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

    pet0 = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
    pet1 = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
    pet2 = shelter.pets.create!(name: "Fluffy 2", approximate_age: 5, sex: 'male', description: 'super cute')
    application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80410")
    application2 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80410")

    a1p1 = ApplicationPet.create(pet: pet1, application: application1)
    a2p2 = ApplicationPet.create(pet: pet2, application: application2)

    pet1.update(adoptable: false)
    a1p1.update(status: "Approve")

    visit "/admin/shelters/#{shelter.id}"
    #Average Pet Age
    expect(page).to have_content("Average Pet Age: 4")
    #Count of Adoptable Pets
    expect(page).to have_content("Adoptable Pets: 2")
    #Count of Pets That Have Been Adopted
    expect(page).to have_content("Adopted Pets: 1")
  end

  it "has an action required section with pets that have pending applications as well as links to those applications" do
    expect(page).to have_content("Action Required")

    pet0 = @shelter1.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute', adoptable: false)
    pet1 = @shelter1.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
    pet2 = @shelter1.pets.create!(name: "Fluffy 2", approximate_age: 5, sex: 'male', description: 'super cute')
    application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80410")
    application2 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80410")

    a1p1 = ApplicationPet.create(pet: pet1, application: application1)
    a2p2 = ApplicationPet.create(pet: pet2, application: application1)


    visit "/admin/shelters/#{@shelter1.id}"
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)

    expect(page).to have_link("view application")
    click_link("view application", match: :first)

    expect(current_path).to eq("/admin/applications/#{application1.id}")

  end
end
