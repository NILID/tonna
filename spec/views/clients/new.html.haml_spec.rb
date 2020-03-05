require 'rails_helper'

RSpec.describe "clients/new", type: :view do
  before(:each) do
    assign(:client, Client.new(
      :title => "MyString",
      :desc => "MyText",
      :email => "MyString",
      :phone => "MyString",
      :url => "MyString",
      :site => "MyString",
      :send_hello => false
    ))
  end

  it "renders new client form" do
    render

    assert_select "form[action=?][method=?]", clients_path, "post" do

      assert_select "input#client_title[name=?]", "client[title]"

      assert_select "textarea#client_desc[name=?]", "client[desc]"

      assert_select "input#client_email[name=?]", "client[email]"

      assert_select "input#client_phone[name=?]", "client[phone]"

      assert_select "input#client_url[name=?]", "client[url]"

      assert_select "input#client_site[name=?]", "client[site]"

      assert_select "input#client_send_hello[name=?]", "client[send_hello]"
    end
  end
end
