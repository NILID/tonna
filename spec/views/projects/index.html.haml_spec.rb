require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    @project = create_list(:project, 2, :with_preview)
  end

  it "renders a list of projects" do
    render
    assert_select "article>.post-title", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
