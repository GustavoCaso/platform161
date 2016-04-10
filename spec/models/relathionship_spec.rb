require 'rails_helper'

describe Relationship do
  context 'Validation' do
    it 'fail with empty follower_id' do
      r = build(:relationship, follower_id: nil)
      expect(r).to_not be_valid
    end
    it 'fail with empty followed_id' do
      r = build(:relationship, followed_id: nil)
      expect(r).to_not be_valid
    end
  end
end
