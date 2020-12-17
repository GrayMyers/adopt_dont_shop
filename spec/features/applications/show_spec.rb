require "rails_helper"

describe "application show page" do
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

  it "displays all related application info on application show page" do
    visit "/applications/#{@application1.id}"
    expect(page).to have_content(@application1.applicant)
    expect(page).to have_content(@application1.address)
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
    expect(page).to_not have_content(@pet3.name)
  end

  it "Has a button to add pets" do
    visit "/applications/#{@application1.id}"
    expect(page).to have_button("Add Pet")
    click_on "Add Pet"
    expect(current_path).to eq("/applications/#{@application1.id}/pets")
  end

  it "has a submit button only after adding pets to application" do
    visit "/applications/#{@application2.id}"

    expect(page).to_not have_button("Submit")

    ApplicationPet.create(application: @application2, pet: @pet1)
    ApplicationPet.create(application: @application2, pet: @pet2)

    visit "/applications/#{@application2.id}"

    expect(page).to have_button("Submit")
  end

  it "redirects to edit page after clicking submit" do
    visit "/applications/#{@application1.id}"
    click_on "Submit"
    expect(current_path).to eq("/applications/#{@application1.id}/edit")
  end
end
