class PatientTest
	include Mongoid::Document
	
	field :name, type: String
	field :result, type: String

	belongs_to :user
end
