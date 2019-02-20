require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.create' do
    context 'when providing a blank password' do
      subject do
        user = build(:user)
        user.password = ''
        user.save
        user
      end

      it 'does not validate' do
        expect(subject).not_to be_persisted
      end
    end

    context 'when providing a non blank password' do
      subject do
        user = build(:user)
        user.password = 'hello'
        user.save
        user
      end

      it 'validates' do
        expect(subject).to be_persisted
      end
    end
  end
end
