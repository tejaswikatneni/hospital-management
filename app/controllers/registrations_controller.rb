class RegistrationsController < Devise::RegistrationsController

	def create
		if resource_name == :user
			super
			if resource.persisted?
				resource.add_role :personal
			end
		else			
			build_resource(sign_up_params)
			render :new
		end
	end

	private

	def sign_up_params
		params.require(:user).permit(:first_name, :last_name, :account_number, :password, :location, :password_confirmation, :phone, :weight, :temperature)
	end
end