require 'rails_helper'

RSpec.feature "Contacts", type: :feature do
  context "Contact Page" do
    Steps "Going to the contacts page" do
      Given "I am on the contacts page" do
        visit "/contacts"
      end
      Then "I can see all contact information" do
        expect(page).to have_content("All Contacts")
      end #end of then
    end #end of steps
  end #end of context
  context "Update a contact" do
    Steps "Going to the contacts page" do
      Given "I am on the contacts page" do
        visit "/contacts"
      end
      Then "I can see all contact information" do
        expect(page).to have_content("All Contacts")
      end
      And "I can click a button to update a contact" do
        click_button "Update"
      end
      Then "I can enter a family name to search for my contact" do
        fill_in 'family_name', with: 'Old'
      end
      And 'I can submit the search' do
        click_button 'submit'
      end
      Then 'I can see the contact info in editable fields' do
        expect(page).to have_content('Gregg')
        expect(page).to have_content('Old')
        expect(page).to have_content('baileys@shoe.com')
        expect(page).to have_content('123 Baileys Shoe Lane')
      end
      Then 'I can update contact info' do
        fill_in 'given_name', with: "Pierce"
        fill_in 'family_name', with: "New"
        fill_in 'email', with: 'twochainz@pierce.com'
        fill_in 'address', with: '123 Sky Comma Road'
      end
      Then 'I can submit the updated information' do
        click_button 'update'
      end
      Then 'I am taken to a page where I can see the updated information'
        expect(page).to have_content('Pierce')
        expect(page).to have_content('New')
        expect(page).to have_content('twochainz@pierce.com')
        expect(page).to have_content('123 Sky Comma Road')
      end #end of last then
    end #end of steps
  end #end of context
end #end of rspec.feature
