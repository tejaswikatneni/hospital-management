require 'rails_helper'

RSpec.describe "hospital_profiles/edit", type: :view do
	before(:each) do
		@hospital_profile = assign(:hospital_profile, HospitalProfile.create!(
			:name => "MyString",
			:about => "MyString",
			:location => "MyString"
		))
	end

	it "renders the edit hospital_profile form" do
		render
		assert_select "form[action=?][method=?]", hospital_profile_path(@hospital_profile), "post" do
			assert_select "input#hospital_profile_name[name=?]", "hospital_profile[name]"
			assert_select "input#hospital_profile_location[name=?]", "hospital_profile[location]"
		end
	end
end
