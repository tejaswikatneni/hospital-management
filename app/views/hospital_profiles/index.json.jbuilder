json.array!(@hospital_profiles) do |hospital_profile|
  json.extract! hospital_profile, :id, :name, :staff, :location
  json.url hospital_profile_url(hospital_profile, format: :json)
end
