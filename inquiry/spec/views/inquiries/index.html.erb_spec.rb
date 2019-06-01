require 'rails_helper'

RSpec.describe "inquiries/index", type: :view do
  before(:each) do
    assign(:inquiries, [
      Inquiry.create!(
        :inquiry_cd => "MyText",
        :inquiry_content => "MyText",
        :accept_cd => "MyText",
        :error_json => "MyText"
      ),
      Inquiry.create!(
        :inquiry_cd => "MyText",
        :inquiry_content => "MyText",
        :accept_cd => "MyText",
        :error_json => "MyText"
      )
    ])
  end

  it "renders a list of inquiries" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
