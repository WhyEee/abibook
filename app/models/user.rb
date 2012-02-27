class User < ActiveRecord::Base
  belongs_to :student
  enum_attr :role, %w(^user staff admin), :nil => false
  validates :full_name, :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  def active_for_authentication?
    super && !student_id.nil?
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :full_name, :email, :password, :password_confirmation, :remember_me
end
