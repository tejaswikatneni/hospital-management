require 'rails_helper'

RSpec.describe "hospital_profiles/new", type: :view do
	before(:each) do
		assign(:hospital_profile, HospitalProfile.new(
			:name => "MyString",
			:about => "MyString",
			:location => "MyString"
		))
	end

	it "renders new hospital_profile form" do
		render
		assert_select "form[action=?][method=?]", hospital_profiles_path, "post" do
			assert_select "input#hospital_profile_name[name=?]", "hospital_profile[name]"
			assert_select "input#hospital_profile_location[name=?]", "hospital_profile[location]"
		end
	end
end