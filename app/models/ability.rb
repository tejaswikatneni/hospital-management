class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new
        if user.roles.count > 0
            user.roles.each do |role|
                role.permissions.each do |permission|
                    if permission.subject_class == 'all'
                        can permission.action.to_sym, permission.subject_class.to_sym
                    else
                        can permission.action.to_sym, permission.subject_class.constantize
                    end
                end
            end
        else
            can :read, :all
        end
    end
end
