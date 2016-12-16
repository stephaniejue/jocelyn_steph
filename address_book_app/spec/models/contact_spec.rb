require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "can be made" do
    expect{Contact.new}.to_not raise_error
  end
  it "has contact info (given, last, email, address)" do
    contact = Contact.new
    contact.given_name = "Gregg"
    contact.family_name = "Old"
    contact.email = "shoe@baileys.gov"
    contact.address = "123 Baileys Shoe Lane"
    expect(contact.save).to eq true
    contact1 = Contact.find_by_given_name("Gregg")
    expect(contact1.given_name).to eq "Gregg"
    expect(contact1.family_name).to eq "Old"
    expect(contact1.email).to eq "shoe@baileys.gov"
    expect(contact1.address).to eq "123 Baileys Shoe Lane"
  end
end
