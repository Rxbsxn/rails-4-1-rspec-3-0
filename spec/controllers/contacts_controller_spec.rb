require 'rails_helper'

describe ContactsController do
  describe 'admin' do
    before :each do
      user = create(:admin)
      session[:user_id] = user.id
    end
  
  describe 'GET #index' do
  
    context 'with params[:letter]' do
      it 'populates an array of contacts starting with the letter' do
        create(:contact, lastname: 'Jon')
        herbert = create(:contact, lastname: 'Herbert')

        get :index, params: { letter: 'H' }

        expect(assigns(:contacts)).to match_array([herbert])
      end

      it 'renders the :index template' do
        get :index, params: { letter: 'Z' }

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
    before :each do
      @phones = [
        attributes_for(:phone),
        attributes_for(:phone),
        attributes_for(:phone)
      ]
    end

    context 'with valid attributes' do
      it 'saves the new contact in the database' do
        @phones = [
          attributes_for(:phone),
          attributes_for(:phone),
          attributes_for(:phone)
        ]
        post :create, params: { contact: attributes_for(:contact, phones_attributes: @phones) }
        
        expect(Contact.count).to eq 1
      end

      it 'redirects to contacts#show' do
        @phones = [
          attributes_for(:phone),
          attributes_for(:phone),
          attributes_for(:phone)
        ]
        post :create, params: { contact: attributes_for(:contact, phones_attributes: @phones) }

        expect(response).to redirect_to contact_path(assigns[:contact])        
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new contact in the database' do 
        post :create, params: { contact: attributes_for(:invalid_contact) }

        expect(Contact.count).to eq 0
      end

      it 're-renders the :new template' do
        post :create, params: { contact: attributes_for(:invalid_contact) }

        expect(response).to render_template(:new)
      end 
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the contact in the database' do
        @contact = create(:contact, firstname: 'Janusz', lastname: 'Wolny')
        patch :update, params: { id: @contact, contact: attributes_for(:contact) }
        
        expect(assigns(:contact)).to eq(@contact)
      end

      it 'redirects to the contact' do
        @contact = create(:contact, firstname: 'Janusz', lastname: 'Wolny')
        patch :update, params: { id: @contact, contact: attributes_for(:contact) }

        expect(response).to redirect_to @contact
      end
    end

    context 'with invalid attributes' do
      it 'does not update the contact' do
        @contact = create(:contact, firstname: 'Janusz', lastname: 'Wolny')
        patch :update, params: { id: @contact, contact: attributes_for(:contact, firstname: 'Adam', lastname: nil) } 
        
        @contact.reload

        expect(@contact.firstname).not_to eq("Adam")
        expect(@contact.lastname).to eq 'Wolny'
      end
      
      it 're-renders the :edit template' do
        @contact = create(:contact, firstname: 'Janusz', lastname: 'Wolny')
        patch :update, params: { id: @contact, contact: attributes_for(:contact, firstname: nil) }

        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the contact from the database' do
      contact = create(:contact)
      
      expect { delete :destroy, params: { id: contact } }.to change(Contact, :count).by(-1)
    end

    it 'redirects to users#index' do
      contact = create(:contact)

      delete :destroy, params: { id: contact }

      expect(response).to redirect_to contacts_url 
    end
  end
  end
end
