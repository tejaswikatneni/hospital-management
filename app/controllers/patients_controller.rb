class PatientsController < ApplicationController
	
	before_filter :is_hospital?, :except => [:show, :edit, :update_profile]
	before_action :set_patient, only: [:manage_patient, :update_patient, :manage_test, :update_test, :destroy_test, :show, :edit, :update_profile]
	
	def index
		@users = User.where(:id.ne => current_user.id)
	end

	def show
	end

	def edit
	end

	def update_profile
		@patient.first_name = params[:user][:first_name]
		@patient.last_name = params[:user][:last_name]
		@patient.location = params[:user][:location]
		@patient.save
		redirect_to profile_path
		flash[:notice] = 'User updated successfully'
	end

	def manage_patient
	end

	def update_patient
		@patient.update(weight: params[:user][:weight], temperature: params[:user][:temperature])
		redirect_to manage_patient_path
		flash[:notice] = 'Patient measures updated successfully'
	end

	def manage_test
		@patient_test = PatientTest.new
		@patient_tests = @patient.patient_tests
	end

	def update_test
		@patient_test = @patient.patient_tests.new(patient_test_params)
		if @patient_test.save
			flash[:alert] = 'Patient condition recorded'
		end
		redirect_to manage_test_path(@patient)
	end

	def destroy_test
		@patient_test = PatientTest.find(params[:pid])
		@patient_test.destroy
		redirect_to manage_test_path(@patient)
		flash[:notice] = 'Test removed successfully'
	end	

	private

	def set_patient
		@patient = User.find(params[:id])
	end

	def patient_test_params
		params.require(:patient_test).permit(:name, :result)
	end

	def is_hospital?
		redirect_to root_path, flash: { notice: 'Access denied. You are not authorized to access the requested page. Only hospital management can access roles.' } and return unless current_user.has_role? :hospital
	end
end