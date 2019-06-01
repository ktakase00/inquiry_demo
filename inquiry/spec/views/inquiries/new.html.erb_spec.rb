require 'rails_helper'

RSpec.describe "inquiries/new", type: :view do
  before(:each) do
    assign(:inquiry, Inquiry.new(
      :inquiry_cd => "MyText",
      :inquiry_content => "MyText",
      :accept_cd => "MyText",
      :error_json => "MyText"
    ))
  end

  it "renders new inquiry form" do
    render

    assert_select "form[action=?][method=?]", inquiries_path, "post" do

      assert_select "textarea[name=?]", "inquiry[inquiry_cd]"

      assert_select "textarea[name=?]", "inquiry[inquiry_content]"

      assert_select "textarea[name=?]", "inquiry[accept_cd]"

      assert_select "textarea[name=?]", "inquiry[error_json]"
    end
  end
end
