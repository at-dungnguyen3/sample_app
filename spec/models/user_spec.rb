# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Create new user' do
    context 'have name, email and password' do
      it 'returns true' do
        expect(User.new(name: 'dung', email: 'dung.nguyen3@asiantech.vn', password: '123456', password_confirmation: '123456').save).to eq(true)
      end
    end

    context 'have no name' do
      it 'show name error message' do
        user = User.create(email: 'dung.nguyen3@asiantech.vn', password: '123456', password_confirmation: '123456')
        expect(user.errors.messages[:name]).to eq(["can't be blank"])
      end
    end

    context 'name is too long' do
      it 'show name error message' do
        user = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen' * 50, email: 'dung.nguyen3@asiantech.vn', password: '123456', password_confirmation: '123456')
        expect(user.errors.messages[:name]).to eq(['is too long (maximum is 50 characters)'])
      end
    end

    context 'have no email' do
      it 'show email error message' do
        user = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen', password: '123456', password_confirmation: '123456')
        expect(user.errors.messages[:email]).to eq(["can't be blank", 'is invalid'])
      end
    end

    context 'has email wrong format' do
      it 'show email error message' do
        user = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen', email: 'abcd', password: '123456', password_confirmation: '123456')
        expect(user.errors.messages[:email]).to eq(['is invalid'])
      end
    end

    context 'has duplicate email' do
      it 'show email error message' do
        user1 = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen', email: 'abcd@gmail.com', password: '123456', password_confirmation: '123456')
        user2 = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen', email: 'abcd@gmail.com', password: '123456', password_confirmation: '123456')
        expect(user2.errors.messages[:email]).to eq(['has already been taken'])
      end
    end

    context 'email is too long' do
      it 'show email error message' do
        user = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen', email: 'abcd' * 260 + '@gmail.com', password: '123456', password_confirmation: '123456')
        expect(user.errors.messages[:email]).to eq(['is too long (maximum is 255 characters)'])
      end
    end

    context 'have no password' do
      it 'show password error message' do
        user = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen' * 50, email: 'abcd@gmail.com')
        expect(user.errors.messages[:password]).to eq(['is too short (minimum is 6 characters)', "can't be blank"])
      end
    end

    context 'has password too short' do
      it 'show password error message' do
        user = User.create(name: 'Nho Phong Lưu Phước Bình Bông Sen' * 50, email: 'abcd@gmail.com', password: '123')
        expect(user.errors.messages[:password]).to eq(['is too short (minimum is 6 characters)'])
      end
    end

    context 'has wrong password_confirmination' do
      it 'returns false' do
        expect(User.new(name: 'Nho Phong Lưu Phước Bình Bông Sen' * 50, email: 'abcd@gmail.com', password: '123456', password_confirmation: '456789').save).to eq(false)
      end
    end
  end
end
