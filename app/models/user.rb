class User
	include Mongoid::Document
	rolify :role_cname => 'Role'
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:account_number]

	## Database authenticatable
	field :account_number,			type: String
	field :encrypted_password,		type: String, default: ""
	field :first_name,				type: String
	field :last_name,				type: String
	field :phone,					type: String
	field :weight,					type: String
	field :temperature,				type: String
	field :location,				type: String

	## Recoverable
	field :reset_password_token,   type: String
	field :reset_password_sent_at, type: Time

	## Rememberable
	field :remember_created_at, type: Time

	## Trackable
	field :sign_in_count,      type: Integer, default: 0
	field :current_sign_in_at, type: Time
	field :last_sign_in_at,    type: Time
	field :current_sign_in_ip, type: String
	field :last_sign_in_ip,    type: String

	## Confirmable
	# field :confirmation_token,   type: String
	# field :confirmed_at,         type: Time
	# field :confirmation_sent_at, type: Time
	# field :unconfirmed_email,    type: String # Only if using reconfirmable

	## Lockable
	# field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
	# field :unlock_token,    type: String # Only if unlock strategy is :email or :both
	# field :locked_at,       type: Time
	validates :account_number, :phone, :numericality => true, :length => { :minimum => 10, :maximum => 15 }
	validates_format_of :account_number, :phone, :with =>  /\d[0-9]\)*\z/, :message => 'Only positive number without spaces are allowed'
	validates_uniqueness_of :account_number
	validates_presence_of :account_number
	has_many :patient_tests

	def email_required?
		false
	end

	def email_changed?
		false
	end

	# def self.find_for_database_authentication(conditions={})
	#   find_by(account_number: conditions[:account_number]))
	# end
end
