namespace 'permissions' do

	desc 'Loading all models and their related controller methods in abilities table and creating super admin.'
	task(:permissions => :environment) do
		controller_path = ''
		@controllers_list = []
		#load all the controllers
		evaluate_controller("#{Rails.root}/app/controllers")
		permissions = []
		@controllers_list.each do |controller|
			#only that controller which represents a model
			if controller.permission
				permissions << controller.permission
				#create a universal permission for that model. eg "manage User" will allow all actions on User model.
				write_permission(controller.permission, 'manage', 'manage') #add permission to do CRUD for every model.
				controller.action_methods.each do |method|
					if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/ #add_user, add_user_info, Add_user, add_User
						name, cancan_action = eval_cancan_action(method)
						write_permission(controller.permission, cancan_action, name)
					end
				end
			end
		end
		Permission.pluck(:subject_class).reject{|x| permissions.include? x}.each {|y| Permission.where(subject_class: y).last.destroy}
		puts '****** creating super admin *******'
		@admin = User.create(:account_number => '1234567891', :password => 'hospital123', :password_confirmation => 'hospital123', :phone => '1234567891' )
		@admin.add_role :hospital
		puts '****** Hospital successfully added *****'
		puts '****** adding permissions *****'
		role = Role.where(:name => 'hospital')
		if role.present?
			@permissions = Permission.where(:name => 'manage')
			@permissions.each do |permission|
				role.first.permissions << permission
			end
		end
	end
end

def evaluate_controller(controller_path)
	Dir.new(controller_path).entries.each do |entry|
		if entry =~ /_controller/
			name_space = controller_path.split('/controllers/').second
			if name_space.nil?
				@controllers_list << "#{entry.camelize.gsub('.rb', '')}".classify.constantize
			else
				@controllers_list << "#{name_space}/#{entry.gsub('.rb', '')}".classify.constantize
			end
		elsif entry =~ /^[a-z]*$/
			evaluate_controller("#{controller_path}/#{entry}")
		end
	end
end

#this method returns the cancan action for the action passed.
def eval_cancan_action(action)
	case action.to_s
	when 'index'
		name = 'list'
		cancan_action = 'index' #let the cancan action be the actual method naME
		action_desc = I18n.t :list
	when 'new', 'create'
		name = 'create and update'
		cancan_action = 'create'
		action_desc = I18n.t :create
	when 'show'
		name = 'view'
		cancan_action = 'show'
		action_desc = I18n.t :view
	when 'edit', 'update'
		name = 'create and update'
		cancan_action = 'update'
		action_desc = I18n.t :update
	when 'delete', 'destroy'
		name = 'delete'
		cancan_action = 'destroy'
		action_desc = I18n.t :destroy
	else
		name = action.to_s
		cancan_action = action.to_s
		action_desc = 'Other: ' < cancan_action
	end
	return name, cancan_action
end

#check if the permission is present else add a new one.
def write_permission(model, cancan_action, name)
	permission = Permission.where(subject_class: model, action: cancan_action).last
	unless permission
		permission = Permission.new
		permission.name = name
		permission.subject_class = model
		permission.action = cancan_action
		permission.save
	end
end