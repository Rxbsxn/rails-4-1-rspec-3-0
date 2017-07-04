require 'rails_helper'

describe ContactsController do
  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'populates an array of contacts starting with the letter' do
        jon = create(:contact, lastname: 'Jon')
        herbert = create(:contact, lastname: 'Herbert')

        get :index, letter: 'H'

        expect(assigns(:contacts)).to match_array([herbert])
      end

      it 'renders the :index template' do
        get :index, letter: 'Z'

        expect(response).to render_template :index
      end
    end

    context 'without params[:letter]' do
      it 'populates an array of all contacts' do
        jon = create(:contact, lastname: 'Jon')
        herbert = create(:contact, lastname: 'Herbert')

        get :index

        expect(assigns(:contacts)).to match_array([jon, herbert])
      end
      
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested contact to @contact' do
      contact = create(:contact)
      get :show, params: { id: contact.id }

      expect(assigns(:contact)).to eq contact
    end
    it 'renders the :show template' do
      contact = create(:contact)
      get :show, params: { id: contact.id } 

      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new Contact to @contact' do 
      get :new
      expect(assigns(:contact)).to be_a_new(Contact)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested contact to @contact' do
      contact = create(:contact)

      get :edit, params: { id: contact.id }

      expect(assigns(:contact)).to eq contact
    end

    it 'renders the :edit template' do
      contact = create(:contact)
    
      get :edit, params: { id: contact.id }

      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new contact in the database'
      it 'redirects to contacts#show'
    end

    context 'with invalid attributes' do
      it 'does not save the new contact in the database'
      it 're-renders the :new template'
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the contact in the database'
      it 'redirects to the contact'
    end

    context 'with invalid attributes' do
      it 'does not update the contact'
      it 're-renders the :edit template'
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the contact from the database'
    it 'redirects to users#index'
  end
end
