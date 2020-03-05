require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project, :with_preview) }

  context 'should' do
    it 'have title' do
      project.title = nil
      expect(project.valid?).to be false
      expect(project.errors[:title]).not_to be_empty
    end

    it 'have desc' do
      project.desc = nil
      expect(project.valid?).to be false
      expect(project.errors[:desc]).not_to be_empty
    end

  end
end
