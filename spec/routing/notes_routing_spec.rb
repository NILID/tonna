require "rails_helper"

RSpec.describe NotesController, type: :routing do
  describe "routing" do
    it "routes to #list" do
      expect(:get => "/contacts/list").to route_to("notes#list")
    end

    it "routes to #new" do
      expect(:get => "/contacts/new").to route_to("notes#new")
    end

    it "routes to #create" do
      expect(:post => "/contacts").to route_to("notes#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/contacts/1").to route_to("notes#destroy", :id => "1")
    end
  end
end
