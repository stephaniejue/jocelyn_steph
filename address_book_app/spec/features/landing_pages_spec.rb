require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context "Landing Page" do
    Steps "Going to the landing page" do
      Given "I'm on localhost:3000" do
        visit "/"
      end
      Then "I should see a welcome" do
        expect(page).to have_content("Welcome")
      end
    end
  end
end

context "I can add a contact" do
  Steps "Going to the landing page" do
    Given "I'm on localhost:3000" do
      visit "/"
    end
    Then "I can fill in contact info" do
      fill_in 'given_name', with: 'Gregg'
      fill_in 'family_name', with: 'Old'
      fill_in 'email', with: 'shoe@baileys.gov'
      fill_in 'address', with: '123 Baileys Shoe Lane'
      click_button 'submit'
    end
    Then "I am taken to a page that confirms info" do
      expect(page).to have_content("Gregg")
      expect(page).to have_content("Old")
      expect(page).to have_content("shoe@baileys.gov")
      expect(page).to have_content("123 Baileys Shoe Lane")
    end
  end
end
