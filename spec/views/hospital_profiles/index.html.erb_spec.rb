require 'rails_helper'

RSpec.describe "hospital_profiles/index", type: :view do
  before(:each) do
    assign(:hospital_profiles, [
      HospitalProfile.create!(
        :name => "Name",
        :staff => "Staff",
        :location => "Location"
      ),
      HospitalProfile.create!(
        :name => "Name",
        :staff => "Staff",
        :location => "Location"
      )
    ])
  end

  it "renders a list of hospital_profiles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Staff".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
