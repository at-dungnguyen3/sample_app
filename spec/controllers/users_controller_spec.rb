# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    context 'user exist' do
      it 'redirect to user' do
        User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
        get :show, params: { id: User.last.id }
        expect(response).to render_template(:show)
      end
    end

    context 'user not found' do
      it 'render 404' do
        # User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
        get :show, params: { id: User.last ? User.last.id + 1 : 1 }
        expect(response).to render_template(file: "#{Rails.root}/public/404.html")
      end
    end
  end

  describe 'GET #create' do
    context 'register success' do
      it 'redirect to user' do
        post :create, params: { user: { name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456' } }
        expect(response).to redirect_to(User.last)
        expect(flash.now[:success]).to eq('Register success')
      end
    end

    context 'has no name' do
      it 'render to register' do
        post :create, params: { user: { name: '', email: 'test@gmail.com', password: '123456', password_confirmation: '123456' } }
        expect(response).to render_template(:new)
        expect(flash.now[:danger]).to eq('Register error')
      end
    end

    context 'has no email' do
      it 'render to register' do
        post :create, params: { user: { name: 'Dũng', email: '', password: '123456', password_confirmation: '123456' } }
        expect(response).to render_template(:new)
        expect(flash.now[:danger]).to eq('Register error')
      end
    end

    context 'has no password' do
      it 'render to register' do
        post :create, params: { user: { name: 'Dũng', email: 'test@gmail.com', password: '', password_confirmation: '123456' } }
        expect(response).to render_template(:new)
        expect(flash.now[:danger]).to eq('Register error')
      end
    end

    context 'has wrong password_confirmation' do
      it 'render to register' do
        post :create, params: { user: { name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '' } }
        expect(response).to render_template(:new)
        expect(flash.now[:danger]).to eq('Register error')
      end
    end

    context 'has duplicate email' do
      it 'render to register' do
        User.create(name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456')
        post :create, params: { user: { name: 'Dũng', email: 'test@gmail.com', password: '123456', password_confirmation: '123456' } }
        expect(response).to render_template(:new)
        expect(flash.now[:danger]).to eq('Register error')
      end
    end
  end
end
