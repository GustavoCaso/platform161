require 'rails_helper'

describe Message do
  context 'Validation' do
    it 'fail message with empty content' do
      message = build(:message, content: '')
      expect(message).to_not be_valid
    end

    it 'fail message without user' do
      message = build(:message, user_id: nil)
      expect(message).to_not be_valid
    end

    it 'fial message for content longer than 160 character' do
      message = build(:message, content: 'a' * 161)
      expect(message).to_not be_valid
    end
  end

  context 'Scope' do
    let(:user) { create(:user, :with_password) }
    before do
      3.times do |n|
        create(:message, user: user, created_at: Time.zone.now + (n+1).day)
      end
    end
    it 'retrieve message in descending order (created_at)' do
      messages_created_at = user.messages.pluck(:created_at)
      # We test that the first day is bigger than the last
      expect(messages_created_at.first > messages_created_at.last).to be_truthy
    end
  end
end
