require 'rails_helper'

RSpec.feature "Create Contacts", type: :feature do
  context "Create Contacts Page" do
    Steps "Creating a contact" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I can click a link 'create'" do
        click_link "Create"
      end
      And 'I am taken to a Create Contact page' do
        expect(page).to have_content ("Create Contact")
      end
      Then 'I can fill in new contact information' do
        fill_in 'given_name', with: "First"
        fill_in 'family_name', with: "User"
        fill_in 'email', with: 'first@email.com'
        fill_in 'address', with: 'First Person Lane'
      end
      Then 'I can submit the updated information' do
        click_button 'submit'
      end
      Then "I am taken back to my address book, which has the contact" do
        expect(page).to have_content ("First")
        expect(page).to have_content ("User")
        expect(page).to have_content ("first@email.com")
        expect(page).to have_content ("First Person Lane")
      end #end of then
    end #end of steps
  end #end of context

  context "Create Contacts Page" do
    Steps "Creating a contact" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I can click a link 'create'" do
        click_link "Create"
      end
      And 'I am taken to a Create Contact page' do
        expect(page).to have_content ("Create Contact")
      end
      Then 'I can fill in new contact information' do
        fill_in 'given_name', with: "First"
        fill_in 'family_name', with: "User"
        fill_in 'email', with: 'first@email.com'
        fill_in 'address', with: 'First Person Lane'
      end
      Then 'I can submit the updated information' do
        click_button 'submit'
      end
      Then "I am taken back to my address book, which has the contact" do
        expect(page).to have_content ("First")
        expect(page).to have_content ("User")
        expect(page).to have_content ("first@email.com")
        expect(page).to have_content ("First Person Lane")
      end
      Then "I can click an update link" do
        click_link "Update"
      end
      And "I am taken to the Update Contact page" do
        expect(page).to have_content ("Update Contact")
      end
      Then "I can enter a family name to search for my contact" do
        fill_in 'family_name', with: 'User'
      end
      And 'I can click search to submit' do
        click_button 'Search'
      end
      # Then 'I can see the contact info in editable fields' do
      #   page.should have_field("given_name", with: "First")
      # end
      Then 'I can update contact info' do
        fill_in 'given_name', with: 'First'
        fill_in 'family_name', with: 'Last'
        fill_in 'email', with: 'firstlast@email.com'
        fill_in 'address', with: 'First Last Street'
      end
      Then 'I can submit the updated information' do
        click_button('Update')
      end
      And 'I am taken to a page where I can see the updated information' do
        expect(page).to have_content('First')
        expect(page).to have_content('Last')
        expect(page).to have_content('firstlast@email.com')
        expect(page).to have_content('First Last Street')
      end #end of last then
    end #end of steps
  end #end of context

end #end of rspec.feature
