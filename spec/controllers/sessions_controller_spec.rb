# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'login success' do
      it 'redirect to user' do
        user = User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
        post :create, params: { session: { email: 'test@gmail.com', password: '123456' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'login wrong email' do
      it 'render login' do
        user = User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
        post :create, params: { session: { email: 'test2@gmail.com', password: '123456' } }
        expect(response).to render_template(:new)
        expect(flash.now[:danger]).to eq('Invalid email/password combination')
      end
    end

    context 'login wrong password' do
      it 'render login' do
        user = User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
        post :create, params: { session: { email: 'test@gmail.com', password: '1234567' } }
        expect(response).to render_template(:new)
        expect(flash.now[:danger]).to eq('Invalid email/password combination')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'logout success' do
      it 'redirect to root' do
        user = User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
        session[:user_id] = user.id
        delete :destroy
        expect(response).to redirect_to(root_path)
      end
    end

    # context 'logout error' do
    #   it 'redirect to login' do
    #     user = User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
    #     delete :destroy, params: { sesssion: nil }
    #     expect(response).to redirect_to(login_path)
    #   end
    # end
  end
end
