require "rails_helper"
describe "admin shelter index page" do
  before :each do
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Funny Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter3 = Shelter.create!(name: "Singular Shelter", address: "1 Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

    @pet1 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter3.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")

    @application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "Somewhere")
    ApplicationPet.create(pet: @pet1, application: @application1)
    ApplicationPet.create(pet: @pet2, application: @application1)
    ApplicationPet.create(pet: @pet3, application: @application1)
    visit "/admin/shelters"
  end

  it "lists all shelters in reverse alphabetical order by name" do


    name1 = find(".shelter-#{@shelter1.id}")
    name2 = find(".shelter-#{@shelter2.id}")
    name3 = find(".shelter-#{@shelter3.id}")

    expect(name3).to appear_before(name2)
    expect(name2).to appear_before(name1)

    expect(page).to have_content("Shady Shelter")
    expect(page).to have_content("Silly Shelter")
    expect(page).to have_content("Singular Shelter")
  end

  it "shows shelters with pending application section containing shelters that have pending applications ordered reverse alphabeticallly" do
    shel3 = find(".pending-shelter-#{@shelter3.id}")
    shel2 = find(".pending-shelter-#{@shelter2.id}")
    shel1 = find(".pending-shelter-#{@shelter1.id}")

    header = find(".all-shelter-header")
    expect(shel3).to appear_before(shel2)
    expect(shel2).to appear_before(shel1)
    expect(shel1).to appear_before(header)
  end

  it "has links for each admin shelter" do
    expect(page).to have_link(@shelter1.name)
    click_link(@shelter1.name, match: :first)
    expect(current_path).to eq("/admin/shelters/#{@shelter1.id}")
  end
end
