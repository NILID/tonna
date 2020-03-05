require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    assign(:clients, [
      Client.create!(
        :title => "Title",
        :desc => "MyText",
        :email => "Email",
        :phone => "Phone",
        :url => "Url",
        :site => "Site",
        :send_hello => false
      ),
      Client.create!(
        :title => "Title",
        :desc => "MyText",
        :email => "Email",
        :phone => "Phone",
        :url => "Url",
        :site => "Site",
        :send_hello => false
      )
    ])
  end

  it "renders a list of clients" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Site".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
