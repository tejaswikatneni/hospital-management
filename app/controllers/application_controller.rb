class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :authenticate_user!
	layout :set_layout



	rescue_from CanCan::AccessDenied do |exception|
		flash[:alert] = 'Access denied. You are not authorized to access the requested page.'
		redirect_to root_path
	end

	def set_layout
		if !user_signed_in? || HospitalProfile.count == 0
			'login'
		else
			'application'
		end
	end

	protected

	#derive the model name from the controller. egs UsersController will return User
	def self.permission
		return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
	end

	def load_permissions
		@current_permissions = current_user.roles.each{ |role| role.permissions.collect{|i| [i.subject_class, i.action]} }
	end
end
