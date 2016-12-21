require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context "Landing Page" do
    Steps "Going to the landing page" do
      Given "I'm on localhost:3000" do
        visit "/"
      end
      Then "I should see a 'Address Book'" do
        expect(page).to have_content("Address Book")
      end
      And "I should see a table with contact information" do
        expect(page).to have_content("Given Name")
        expect(page).to have_content("Family Name")
        expect(page).to have_content("Email")
        expect(page).to have_content("Address")
      end
      And "I should see buttons that allow me to sort, create, update, and delete" do
        expect(page).to have_content("Sort")
        expect(page).to have_content("Create")
        expect(page).to have_content("Update")
        expect(page).to have_content("Delete")
      end
    end #end of steps
  end #end of context

end #end of rspec feature
