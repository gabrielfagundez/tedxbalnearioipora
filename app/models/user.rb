class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.load_seeds
    User.create(email: 'gabriel.fagundez@moove-it.com', first_name: 'Gabriel', last_name: 'Fagúndez de los Reyes', password: '123mooveit', password_confirmation: '123mooveit')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
