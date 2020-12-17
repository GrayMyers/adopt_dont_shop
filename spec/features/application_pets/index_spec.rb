require "rails_helper"

describe "application pet index page" do

  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    @pet4 = @shelter1.pets.create!(image:"", name: "Zeus 2", description: "dog", approximate_age: 4, sex: "male")

    @application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80129")
    @application2 = Application.create(applicant: "Jane Doe", description: "I love dogs more than John", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80129")
  end


  it "has a search form that causes the app to list pets matching the search" do
    visit "/applications/#{@application1.id}/pets"
    expect(page).to have_button("Search by Name")
    fill_in "search", with: "Zeus"
    click_on "Search"
    expect(page).to have_content(@pet3.name)

    expect(page).to have_no_content(@pet1.name)
  end

  it "has a button for each pet which creates a new application_pet record" do
    visit "/applications/#{@application1.id}/pets?search=Thor"
    first(:button, 'Adopt').click
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content("Thor")
  end
end
