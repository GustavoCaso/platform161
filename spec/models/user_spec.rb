require 'rails_helper'

describe User do
  context 'Validation' do
    it 'fail user with empty user_name' do
      user = build(:user, user_name: '')
      expect(user).to_not be_valid
    end

    it 'fail user with empty email' do
      user = build(:user, email: '')
      expect(user).to_not be_valid
    end

    it 'fail user with password to short' do
      user = build(:user, password: 'aaaa')
      expect(user).to_not be_valid
    end

    it 'fail user with password_confirmation not equal' do
      user = build(:user, password: 'valid_one', password_confirmation: 'invalid_one')
      expect(user).to_not be_valid
    end

    context 'Uniqueness Validation' do
      let(:saved_user) { create(:user, :with_password) }

      it 'fail for non uniqueness user_name' do
        user = build(:user, :with_password, user_name: saved_user.user_name)
        expect(user).to_not be_valid
      end

      it 'fail for non uniqueness email' do
        user = build(:user, :with_password, email: saved_user.email)
        expect(user).to_not be_valid
      end
    end
  end

  context 'Callbacks' do
    it 'modify email to be upcase' do
      user = create(:user, :with_password, email: 'hello@gmail.com')
      expect(user.email).to eq 'HELLO@GMAIL.COM'
    end
  end

  context 'Messages' do
    it 'delete all messages related to removed user' do
      user = create(:user, :with_password)
      3.times do
        create(:message, user: user)
      end
      expect {
        user.destroy
      }.to change(Message, :count).by(-3)
    end
  end

  context 'Relationships' do
    let(:user) { create(:user, :with_password) }
    context 'Following' do
      it 'will create a active relationship' do
        john = create(:user, :with_password, user_name: 'John')
        expect{
          user.create_following_relationship(john)
        }.to change(Relationship, :count).by(1)
        expect(user.following?(john)).to be_truthy
      end

      it 'will destroy a active relationship' do
        john = create(:user, :with_password, user_name: 'John')
        user.create_following_relationship(john)
        expect{
          user.destroy_following_relationship(john)
        }.to change(Relationship, :count).by(-1)
        expect(user.following?(john)).to be_falsy
      end
    end
    context 'Followers' do
      let(:user_2) { create(:user, :with_password) }
      before { user_2.create_following_relationship(user) }
      it 'will give a list of followers' do
        expect(user.followers).to eq [user_2]
      end
    end
  end
end
