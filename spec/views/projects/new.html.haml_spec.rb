require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    @project = create(:project, :with_preview)
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input#project_title[name=?]", "project[title]"

      assert_select "textarea#project_desc[name=?]", "project[desc]"

      assert_select "input#project_preview[name=?]", "project[preview]"
    end
  end
end
