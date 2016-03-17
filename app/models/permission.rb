class Permission
	include Mongoid::Document

	field :subject_class,					type: String # model names like User, Role, Book, Author
	field :action,							type: String # controller action like new, create or destroy
	field :name,							type: String # controller action like new, create or destroy
end