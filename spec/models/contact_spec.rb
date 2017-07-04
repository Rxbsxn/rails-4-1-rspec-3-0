require 'rails_helper'

describe Contact do
  it 'is valid with firstname, lastname and email' do
    contact = build(:contact)

    expect(contact).to be_valid  
  end
  
  it 'is invalid without firstname' do
    #setup
    contact = build(:contact, firstname: nil)    
    #association
    contact.valid?
    #exec
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it 'is invalid without lastname' do
    contact = build(:contact, lastname: nil)
    
    contact.valid?
    
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it 'is invalid without email' do
    contact = build(:contact, email: nil)

    contact.valid?

    expect(contact.errors[:email]).to include("can't be blank")
  end  

  it 'is invalid with a duplicate email address' do
    create(:contact, email: "cehaujot@gmail.com")
    contact = build(:contact, email: "cehaujot@gmail.com")
    contact.valid?

    expect(contact.errors[:email]).to include('has already been taken')
  end

  it 'returns a contact full name as a string' do
    contact = build(:contact, firstname: "Bogdan", lastname: "Powstaniec")
    
    expect(contact.name).to eq 'Bogdan Powstaniec'
  end
  
  describe '.by_letter' do
    
    context 'array of result that match' do
      it 'returns order array of results' do
        create(:contact, firstname: "John", lastname: 'Smith', email: "12@gc.com")
        johnson = create(:contact, firstname: 'Carl', lastname: "Johnson", email: '14@gc.com')
        jones = create(:contact, firstname: "Adyan", lastname: 'Jones', email: '13@gc.com')
    
        expect(Contact.by_letter("J")).to eq [johnson, jones]
      end
    end

    context 'omits results that do not match' do
      it 'returns array with omitted results' do
        smith = create(:contact, firstname: "John", lastname: 'Smith', email: "12@gc.com")        
        
        expect(Contact.by_letter("J")).not_to include smith
      end
    end
  end

  it 'has three phone numbers' do
    contact = create(:contact)

    expect(contact.phones.count).to eq 3
  end
end
