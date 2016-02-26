require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    context 'with a valid user and email' do
      let(:user) { create(:user) }

      it 'finds the user' do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        post :create, email: user.email
      end

      it 'generates a new password token' do
        expect{ post :create, email: user.email; user.reload }.to change{ user.password_reset_token }
      end

      it 'sets the flash[:success] message' do
        post :create, email: user.email
        expect(flash[:success]).to match(/check your email./)
      end
    end

    context 'with no user found' do
      it 'renders the new page' do
        post :create, email: 'none@found.com'
        expect(response).to render_template('new')
      end

      it 'sets the flash[:notice] message' do
        post :create, email: 'none@found.com'
        expect(flash[:error]).to match(/not found./)
      end
    end
  end
end