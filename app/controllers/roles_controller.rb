class RolesController < ApplicationController
	
	#devise so that only logged-in user can access	
	before_filter :load_permissions
	load_and_authorize_resource
	before_action :set_role, only: [:show, :edit, :update, :destroy, :change_abilities, :update_abilities]

	def index
		@roles = Role.page(params[:page]).per(30)
	end

	def new
		@role = Role.new
	end

	def show
		@abilities = @role.permissions
	end

	def edit

	end

	def create
		@role = Role.new(role_params)
		if @role.save
			flash[:notice] = 'Role was successfully created.'
			redirect_to roles_path
		else
			render 'new'
		end
	end

	def update
		if @role.update(role_params)
			flash[:notice] = 'Role was successfully updated.'
			redirect_to role_path(@role)
		else
			render 'edit'
		end
	end

	def destroy
		@role.destroy
		redirect_to roles_path
	end

	def change_abilities
		@abilities = Permission.all
	end

	def update_abilities
		if params[:ability].present?
			@role.permissions = []
			params[:ability].each do |ability_id|
				ability = Permission.find(ability_id)
				@role.permissions << ability
			end
			redirect_to role_path(@role)
		else
			flash[:notice] = 'Please select atleast one ability'
			redirect_to change_role_abilities_path(@role)
		end
	end

	private

	def role_params
		params.require(:role).permit(:name)
	end

	def set_role
		@role = Role.find(params[:id])
	end
end