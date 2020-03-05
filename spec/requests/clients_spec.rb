require 'rails_helper'

RSpec.describe "Clients", type: :request do
  let!(:client) { create(:client) }

  describe "GET /clients" do
    it "works! (now write some real specs)" do
      get clients_path
      expect(response).to have_http_status(301)
    end
  end
end
