class HospitalProfile
  include Mongoid::Document
  field :name, type: String
  field :about, type: String
  field :location, type: String
end
