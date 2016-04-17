class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  has_and_belongs_to_many :clients
  has_many :favourite_projects

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.role == 'admin'
  end

  def client_manager?
    self.role == 'client_manager'
  end

  def team_member?
    self.role == 'team_member'
  end

end
