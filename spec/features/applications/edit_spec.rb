require "rails_helper"

describe "Description page" do

  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    @application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80129")
    @application2 = Application.create(applicant: "Jane Doe", description: "I love dogs more than John", address: "123 Street", city: "Denver", state: 'Colorado', zip: "80129")

    ApplicationPet.create(application: @application1, pet: @pet1)
    ApplicationPet.create(application: @application1, pet: @pet2)


  end

  it "has a text field that redirects to completed application show page" do
    visit "/applications/#{@application1.id}/edit"
    fill_in "description", with: "I like dogs"
    click_on "Submit"
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content("I like dogs")
  end

  it "does not allow an empty form to be entered" do
    visit "/applications/#{@application1.id}/edit"
    click_on "Submit"
    expect(page).to have_content("Description is too short (minimum is 1 character)")
  end
end
