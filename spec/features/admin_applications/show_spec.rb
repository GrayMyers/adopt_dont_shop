require "rails_helper"

describe "admin application show page" do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")

    @application1 = Application.create(applicant: "John Doe", description: "I love dogs!!!", address: "Somewhere")
    @application2 = Application.create(applicant: "Jane Doe", description: "I love dogs more than John", address: "Somewhere")

    @application1.submitted = true
    @application2.submitted = true

    @application1.save
    @application2.save

    ApplicationPet.create(application: @application1, pet: @pet1)
    ApplicationPet.create(application: @application1, pet: @pet2)

    ApplicationPet.create(application: @application2, pet: @pet3)
    ApplicationPet.create(application: @application2, pet: @pet2)
    visit "/admin/applications/#{@application1.id}"
  end

  it "has a button to approve or reject pets" do
    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
  end

  it "updates page and displays new result after button click" do
    approve = first(:button, "Approve")
    approve.click
    expect(page).to have_content("Approved")
    expect(first(:button, "Approve")).to_not eq(approve) #if the same button is still on the page, there is an issue
    first(:button, "Approve").click
    expect(page).to have_content("Status: Approved")

    visit "/admin/applications/#{@application2.id}"

    reject = first(:button, "Reject")
    reject.click
    expect(page).to have_content("Rejected")
    expect(first(:button, "Reject")).to_not eq(reject)
    first(:button, "Reject").click

    expect(page).to have_content("Status: Rejected")
  end

  it "sets pet adoptable? to false when approved" do
    approve = first(:button, "Approve")
    approve.click
    approve = first(:button, "Approve") #adopt both pets on first application
    approve.click

    visit "/admin/applications/#{@application2.id}"

    expect(page).to have_button("Adopted", disabled: true)
    #expect the page to have a disabled button called adopted
    #because the pet was accepted from the first application
  end
end
