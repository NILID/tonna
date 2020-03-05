require 'rails_helper'

RSpec.describe "containers/new", type: :view do
  before(:each) do
    assign(:container, Container.new(
      :content => "MyText",
      :project => nil,
      :types_mask => 1
    ))
  end

  it "renders new container form" do
    render

    assert_select "form[action=?][method=?]", containers_path, "post" do

      assert_select "textarea#container_content[name=?]", "container[content]"

      assert_select "input#container_project_id[name=?]", "container[project_id]"

      assert_select "input#container_types_mask[name=?]", "container[types_mask]"
    end
  end
end
