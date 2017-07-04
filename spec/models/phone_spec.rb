require 'rails_helper'

describe Phone do
  it 'does not allow duplicate phone numbers per contact' do
    contact = create(:contact)
    create(:home_phone, contact: contact, phone: '123456789')
    mobile_phone = build(:mobile_phone, contact: contact, phone: '123456789')

    mobile_phone.valid?

    expect(mobile_phone.errors[:phone]).to include('has already been taken')

    # #one way to do this
    # contact = Contact.create(firstname: 'Andrew', lastname: 'Śrubka', email: 'kretacz67@gmd.com')
    # contact.phones.create(phone_type: 'home', phone: '123456789')
    # contact.phones.create(phone_type: 'office', phone: '123456789')

    # contact.valid?

    # expect(contact.errors["phones.phone"]).to include('has already been taken')

    #######################################  #second way #################################################
    # contact = Contact.create(firstname: 'Andrew', lastname: 'Śrubka', email: 'kretacz67@gmd.com')
    # contact.phones.create(phone_type: 'home', phone: '123456789')
    # mobile_phone = contact.phones.create(phone_type: 'office', phone: '123456789')

    # mobile_phone.valid?

    # expect(mobile_phone.errors[:phone]).to include('has already been taken')
  end

  it 'allow two contacts to share a phone number' do
    create(:home_phone, phone: '123456789')
    other = build(:home_phone, phone: '123456789')

    expect(other).to be_valid 
  end
end
