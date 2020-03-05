require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @project = create(:project, :with_preview)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
