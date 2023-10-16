require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
   
    it 'should be invalid without a username' do
      user = FactoryBot.build(:user, username: nil)
      expect(user).not_to be_valid
      # expect(user.errors[:username]).to include('nil')
    expect(user.errors.full_messages.size).to eq(3)
    end
  
    it 'should be invalid with a blank username' do
      user = FactoryBot.build(:user, username: ' ')
      expect(user).not_to be_valid
      expect(user.errors.full_messages.size).to eq(3)
      end
  
    it 'should be invalid with a username longer than 30 characters' do
      user = FactoryBot.build(:user, username: 'a' * 31)
      expect(user).not_to be_valid
      expect(user.errors.full_messages.size).to eq(2)

    end
  
    it 'should be valid with a valid username' do
      user = FactoryBot.build(:user, username: 'valid_username')
      expect(user).to be_valid
    end
  
    it 'should be invalid without a password' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
      # expect(user.errors.full_messages.size).to eq(2)
      expect(user.errors[:username]).to include('nil')

    end
  
    it 'should be invalid with a short password' do
      user = FactoryBot.build(:user, password: 'short')
      expect(user).not_to be_valid
      expect(user.errors.full_messages.size).to eq(2)
    end
  end
  


end
