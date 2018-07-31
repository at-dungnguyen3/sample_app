require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Create new user' do
    context 'have name, email and password' do
      it 'return true' do
        expect(User.new(name: 'dung', email: 'dung.nguyen3@asiantech.vn', password: '123456', password_confirmation: '123456').save).to eq(true)
      end
    end

    context 'have no name, email and password' do
      it 'show errors message' do
        errors_message = User.create().errors.messages
        expect(errors_message).to eq({:name=>["can't be blank"], :email=>["can't be blank", "is invalid"], :password=>["can't be blank"]})
      end
    end
  end
end
