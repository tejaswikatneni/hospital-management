require 'rails_helper'

RSpec.describe HospitalProfilesController, type: :controller do

	before(:each) do
		@hospital = User.find_by(account_number: '1234567891')
		sign_in @hospital
	end

	# This should return the minimal set of attributes required to create a valid
	# HospitalProfile. As you add validations to HospitalProfile, be sure to
	# adjust the attributes here as well.
	let(:valid_attributes) {
		FactoryGirl.attributes_for(:hospital_profile)
	}

	let(:invalid_attributes) {
		{name: '', about: 'About Hospital', location: 'Hyderabad'}
	}

	# This should return the minimal set of values that should be in the session
	# in order to pass any filters (e.g. authentication) defined in
	# HospitalProfilesController. Be sure to keep this updated too.
	let(:valid_session) { {} }

	describe "GET #show" do
		it "assigns the requested hospital_profile as @hospital_profile" do
			hospital_profile = HospitalProfile.create! valid_attributes
			get :show, {:id => hospital_profile.to_param}, valid_session
			expect(assigns(:hospital_profile)).to eq(hospital_profile)
		end
	end

	describe "GET #new" do
		it "assigns a new hospital_profile as @hospital_profile" do
			get :new, {}, valid_session
			expect(assigns(:hospital_profile)).to be_a_new(HospitalProfile)
		end
	end

	describe "GET #edit" do
		it "assigns the requested hospital_profile as @hospital_profile" do
			hospital_profile = HospitalProfile.create! valid_attributes
			get :edit, {:id => hospital_profile.to_param}, valid_session
			expect(assigns(:hospital_profile)).to eq(hospital_profile)
		end
	end

	describe "POST #create" do
		context "with valid params" do
			it "creates a new HospitalProfile" do
				@hospital = User.find_by(account_number: '1234567891')
				sign_in @hospital
				expect {
					post :create, {:hospital_profile => valid_attributes}, valid_session
				}.to change(HospitalProfile, :count).by(1)
			end

			it "assigns a newly created hospital_profile as @hospital_profile" do
				post :create, {:hospital_profile => valid_attributes}, valid_session
				expect(assigns(:hospital_profile)).to be_a(HospitalProfile)
				expect(assigns(:hospital_profile)).to be_persisted
			end

			it "redirects to the created hospital_profile" do
				post :create, {:hospital_profile => valid_attributes}, valid_session
				expect(response).to redirect_to(root_path)
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved hospital_profile as @hospital_profile" do
				post :create, {:hospital_profile => invalid_attributes}, valid_session
				expect(assigns(:hospital_profile)).to be_a_new(HospitalProfile)
			end

			it "re-renders the 'new' template" do
				post :create, {:hospital_profile => invalid_attributes}, valid_session
				expect(response).to render_template("new")
			end
		end
	end

	describe "PUT #update" do
		context "with valid params" do
			it "updates the requested hospital_profile" do
				hospital_profile = HospitalProfile.create! valid_attributes
				put :update, {:id => hospital_profile.to_param, :hospital_profile => {about: 'KIMS'}}, valid_session
				hospital_profile.reload
				expect(assigns(:hospital_profile)).to eq(hospital_profile)
			end

			it "assigns the requested hospital_profile as @hospital_profile" do
				hospital_profile = HospitalProfile.create! valid_attributes
				put :update, {:id => hospital_profile.to_param, :hospital_profile => valid_attributes}, valid_session
				expect(assigns(:hospital_profile)).to eq(hospital_profile)
			end

			it "redirects to the hospital_profile" do
				hospital_profile = HospitalProfile.create! valid_attributes
				put :update, {:id => hospital_profile.to_param, :hospital_profile => valid_attributes}, valid_session
				expect(response).to redirect_to(hospital_profile)
			end
		end

		context "with invalid params" do
			it "assigns the hospital_profile as @hospital_profile" do
				hospital_profile = HospitalProfile.create! valid_attributes
				put :update, {:id => hospital_profile.to_param, :hospital_profile => invalid_attributes}, valid_session
				expect(assigns(:hospital_profile)).to eq(hospital_profile)
			end

			it "re-renders the 'edit' template" do
				hospital_profile = HospitalProfile.create! valid_attributes
				put :update, {:id => hospital_profile.to_param, :hospital_profile => invalid_attributes}, valid_session
				expect(response).to render_template("edit")
			end
		end
	end
end