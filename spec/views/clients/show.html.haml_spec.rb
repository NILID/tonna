require 'rails_helper'

RSpec.describe "clients/show", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :title => "Title",
      :desc => "MyText",
      :email => "Email",
      :phone => "Phone",
      :url => "Url",
      :site => "Site",
      :send_hello => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Site/)
    expect(rendered).to match(/false/)
  end
end
