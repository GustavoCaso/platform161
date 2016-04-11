require 'rails_helper'

describe PasswordForm do
  let(:user) { create(:user, password: 'tested', password_confirmation: 'tested') }
  subject { described_class.new(user) }

  context 'Valid Data' do
    it 'update user password' do
      params = { original_password: 'tested', new_password: 'new_test', new_password_confirmation: 'new_test' }
      expect{
        subject.submit(params)
      }.to change(user, :password_digest)
    end
  end

  context 'Invalid Data' do
    it 'will add errors' do
      params = { original_password: 'not_tested', new_password: 'new_test', new_password_confirmation: 'new_test' }
      subject.submit(params)
      expect(subject.valid?).to be_falsy
      expect(subject.errors).to_not be_empty
    end
  end
end
