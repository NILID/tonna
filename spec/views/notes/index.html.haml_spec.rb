require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  it "renders a index of notes" do
    @note = Note.new
    render

    assert_select "form[action=?][method=?]", note_path(@note), "post" do
      assert_select "textarea#note_content[name=?]", "note[content]"
      assert_select "input#note_email[name=?]", "note[email]"
    end
  end
end
