class HospitalProfile
	include Mongoid::Document
	
	field :name, type: String
	field :about, type: String
	field :location, type: String

	validates_presence_of :name, :about, :location
end