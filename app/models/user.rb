class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  has_and_belongs_to_many :clients
  belongs_to :account
  has_many :favorite_projects
  has_many :user_events
  has_many :time_entries

  def full_name
    "#{first_name} #{last_name}"
  end

  def gravatar_image_url
    Gravatar.new(self.email).image_url
  end

  def admin?
    self.role == 'admin' || self.role == 'beta'
  end

  def client_manager?
    self.role == 'client_manager'
  end

  def team_member?
    self.role == 'team_member'
  end

  def visible_clients
    if self.admin?
      self.account.clients.includes(:projects)
    else
      self.clients.includes(:projects)
    end
  end

end
