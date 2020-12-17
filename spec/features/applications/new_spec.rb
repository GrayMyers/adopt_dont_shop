require "rails_helper"

describe "New page" do

  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    visit "/applications/new"
  end

  it "has fields for information to fill out" do
    expect(page).to have_field("applicant")
    expect(page).to have_field("address")
    expect(page).to have_field("city")
    expect(page).to have_field("state")
    expect(page).to have_field("zip")
    expect(page).to have_button("Submit")
  end

  it "creates a new application and redirects to the application's show page" do
    fill_in "applicant", with: "John Doe"
    fill_in "address", with: "1234 Some Street"
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in "zip", with: "80000"
    click_on "Submit"
    processed = current_path.split("/")
    expect(processed[1]).to eq("applications")
    expect(processed[2].length).to eq(processed[2].to_i.to_s.length)

    expect(page).to have_content("John Doe")
    expect(page).to have_content("1234 Some Street")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("80000")
  end
end
