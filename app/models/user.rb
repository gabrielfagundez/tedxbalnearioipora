class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  has_and_belongs_to_many :clients
  belongs_to :account
  has_many :favorite_projects
  has_many :widgets
  has_many :user_events
  has_many :time_entries
  has_many :weekly_entries

  def full_name
    "#{first_name} #{last_name}"
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

  def gravatar_image_url
    Gravatar.new(self.email).image_url
  end

  def summary
    UserTimeUsageChart.new(self).chart_data
  end

  def average(value, total)
    if total == 0.0
      0
    else
      (value * 100 / total).round(1)
    end
  end

  def total_hours_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.communication + we.development + we.bugs + we.code_review + we.qa + we.infraestructure + we.uxui }.sum().to_f
  end

  def total_communication_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.communication }.sum().to_f
  end

  def total_development_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.development }.sum().to_f
  end

  def total_bugs_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.bugs }.sum().to_f
  end

  def total_code_review_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.code_review }.sum().to_f
  end

  def total_qa_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.qa }.sum().to_f
  end

  def total_infraestructure_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.infraestructure }.sum().to_f
  end

  def total_uxui_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.uxui }.sum().to_f
  end

end
