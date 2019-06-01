require 'rails_helper'

RSpec.describe "inquiries/edit", type: :view do
  before(:each) do
    @inquiry = assign(:inquiry, Inquiry.create!(
      :inquiry_cd => "MyText",
      :inquiry_content => "MyText",
      :accept_cd => "MyText",
      :error_json => "MyText"
    ))
  end

  it "renders the edit inquiry form" do
    render

    assert_select "form[action=?][method=?]", inquiry_path(@inquiry), "post" do

      assert_select "textarea[name=?]", "inquiry[inquiry_cd]"

      assert_select "textarea[name=?]", "inquiry[inquiry_content]"

      assert_select "textarea[name=?]", "inquiry[accept_cd]"

      assert_select "textarea[name=?]", "inquiry[error_json]"
    end
  end
end
