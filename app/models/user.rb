class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable

  has_and_belongs_to_many :clients
  has_many :favourite_projects

  def self.load_seeds
    User.create(email: 'gabriel.fagundez@moove-it.com', first_name: 'Gabriel', last_name: 'Fagúndez de los Reyes', password: '123mooveit', password_confirmation: '123mooveit')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.role == 'admin'
  end

end
