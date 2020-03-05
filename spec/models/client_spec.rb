require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  context 'should' do
    it 'have title' do
      client.title = nil
      expect(client.valid?).to be false
      expect(client.errors[:title]).not_to be_empty
    end

    it 'have email' do
      client.email = nil
      expect(client.valid?).to be false
      expect(client.errors[:email]).not_to be_empty
    end


    it 'have url' do
      client.url = nil
      expect(client.valid?).to be false
      expect(client.errors[:url]).not_to be_empty
    end

    it 'have valid email' do
      client.email = 'emaildotcom'
      expect(client.valid?).to be false
      expect(client.errors[:email]).not_to be_empty
    end

    it 'have not unique siteurl' do
      client.save!
      new_client = build(:client)
      new_client.url = client.url
      expect(new_client.valid?).to be false
      expect(new_client.errors[:url]).not_to be_empty
    end
  end
end
