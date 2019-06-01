require 'rails_helper'

RSpec.describe "inquiries/show", type: :view do
  before(:each) do
    @inquiry = assign(:inquiry, Inquiry.create!(
      :inquiry_cd => "MyText",
      :inquiry_content => "MyText",
      :accept_cd => "MyText",
      :error_json => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
