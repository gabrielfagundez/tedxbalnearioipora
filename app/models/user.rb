class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.load_seeds
    User.create(email: 'gabriel.fagundez@moove-it.com', password: '123mooveit', password_confirmation: '123mooveit')
  end

end
