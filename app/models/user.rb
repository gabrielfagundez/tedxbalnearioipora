class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable

  has_and_belongs_to_many :clients
  belongs_to :account
  has_many :favorite_projects
  has_many :user_events
  has_many :time_entries
  has_many :weekly_entries

  def full_name
    "#{first_name} #{last_name}"
  end

  def beta?
    self.role == 'beta'
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

  def gravatar_image_url
    Gravatar.new(self.email).image_url
  end

  def summary
    weeks = [
      (Date.today.beginning_of_week(:monday) - 10.week).to_s,
      (Date.today.beginning_of_week(:monday) - 9.week).to_s,
      (Date.today.beginning_of_week(:monday) - 8.week).to_s,
      (Date.today.beginning_of_week(:monday) - 7.week).to_s,
      (Date.today.beginning_of_week(:monday) - 6.week).to_s,
      (Date.today.beginning_of_week(:monday) - 5.week).to_s,
      (Date.today.beginning_of_week(:monday) - 4.week).to_s,
      (Date.today.beginning_of_week(:monday) - 3.week).to_s,
      (Date.today.beginning_of_week(:monday) - 2.week).to_s,
      (Date.today.beginning_of_week(:monday) - 1.week).to_s
    ]

    {
      labels: [weeks[0], weeks[1], weeks[2], weeks[3], weeks[4], weeks[5], weeks[6], weeks[7], weeks[8], weeks[9]],
      datasets: [
        {
          label: "Communication",
          fillColor: "rgba(127,127,255,0.2)",
          strokeColor: "rgba(127,127,255,1)",
          pointColor: "rgba(127,127,255,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(127,127,255,1)",
          data: [
            average(total_communication_for_week(weeks[0]), total_hours_for_week(weeks[0])),
            average(total_communication_for_week(weeks[1]), total_hours_for_week(weeks[1])),
            average(total_communication_for_week(weeks[2]), total_hours_for_week(weeks[2])),
            average(total_communication_for_week(weeks[3]), total_hours_for_week(weeks[3])),
            average(total_communication_for_week(weeks[4]), total_hours_for_week(weeks[4])),
            average(total_communication_for_week(weeks[5]), total_hours_for_week(weeks[5])),
            average(total_communication_for_week(weeks[6]), total_hours_for_week(weeks[6])),
            average(total_communication_for_week(weeks[7]), total_hours_for_week(weeks[7])),
            average(total_communication_for_week(weeks[8]), total_hours_for_week(weeks[8])),
            average(total_communication_for_week(weeks[9]), total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Development",
          fillColor: "rgba(127,255,127,0.2)",
          strokeColor: "rgba(127,255,127,1)",
          pointColor: "rgba(127,255,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(127,255,127,1)",
          data: [
            average(total_development_for_week(weeks[0]), total_hours_for_week(weeks[0])),
            average(total_development_for_week(weeks[1]), total_hours_for_week(weeks[1])),
            average(total_development_for_week(weeks[2]), total_hours_for_week(weeks[2])),
            average(total_development_for_week(weeks[3]), total_hours_for_week(weeks[3])),
            average(total_development_for_week(weeks[4]), total_hours_for_week(weeks[4])),
            average(total_development_for_week(weeks[5]), total_hours_for_week(weeks[5])),
            average(total_development_for_week(weeks[6]), total_hours_for_week(weeks[6])),
            average(total_development_for_week(weeks[7]), total_hours_for_week(weeks[7])),
            average(total_development_for_week(weeks[8]), total_hours_for_week(weeks[8])),
            average(total_development_for_week(weeks[9]), total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Bugs",
          fillColor: "rgba(255,127,127,0.2)",
          strokeColor: "rgba(255,127,127,1)",
          pointColor: "rgba(255,127,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(255,127,127,1)",
          data: [
            average(total_bugs_for_week(weeks[0]), total_hours_for_week(weeks[0])),
            average(total_bugs_for_week(weeks[1]), total_hours_for_week(weeks[1])),
            average(total_bugs_for_week(weeks[2]), total_hours_for_week(weeks[2])),
            average(total_bugs_for_week(weeks[3]), total_hours_for_week(weeks[3])),
            average(total_bugs_for_week(weeks[4]), total_hours_for_week(weeks[4])),
            average(total_bugs_for_week(weeks[5]), total_hours_for_week(weeks[5])),
            average(total_bugs_for_week(weeks[6]), total_hours_for_week(weeks[6])),
            average(total_bugs_for_week(weeks[7]), total_hours_for_week(weeks[7])),
            average(total_bugs_for_week(weeks[8]), total_hours_for_week(weeks[8])),
            average(total_bugs_for_week(weeks[9]), total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Code Review",
          fillColor: "rgba(127,127,127,0.2)",
          strokeColor: "rgba(127,127,127,1)",
          pointColor: "rgba(127,127,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(127,127,127,1)",
          data: [
            average(total_code_review_for_week(weeks[0]), total_hours_for_week(weeks[0])),
            average(total_code_review_for_week(weeks[1]), total_hours_for_week(weeks[1])),
            average(total_code_review_for_week(weeks[2]), total_hours_for_week(weeks[2])),
            average(total_code_review_for_week(weeks[3]), total_hours_for_week(weeks[3])),
            average(total_code_review_for_week(weeks[4]), total_hours_for_week(weeks[4])),
            average(total_code_review_for_week(weeks[5]), total_hours_for_week(weeks[5])),
            average(total_code_review_for_week(weeks[6]), total_hours_for_week(weeks[6])),
            average(total_code_review_for_week(weeks[7]), total_hours_for_week(weeks[7])),
            average(total_code_review_for_week(weeks[8]), total_hours_for_week(weeks[8])),
            average(total_code_review_for_week(weeks[9]), total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "QA",
          fillColor: "rgba(255,255,127,0.2)",
          strokeColor: "rgba(255,255,127,1)",
          pointColor: "rgba(255,255,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(255,255,127,1)",
          data: [
            average(total_qa_for_week(weeks[0]), total_hours_for_week(weeks[0])),
            average(total_qa_for_week(weeks[1]), total_hours_for_week(weeks[1])),
            average(total_qa_for_week(weeks[2]), total_hours_for_week(weeks[2])),
            average(total_qa_for_week(weeks[3]), total_hours_for_week(weeks[3])),
            average(total_qa_for_week(weeks[4]), total_hours_for_week(weeks[4])),
            average(total_qa_for_week(weeks[5]), total_hours_for_week(weeks[5])),
            average(total_qa_for_week(weeks[6]), total_hours_for_week(weeks[6])),
            average(total_qa_for_week(weeks[7]), total_hours_for_week(weeks[7])),
            average(total_qa_for_week(weeks[8]), total_hours_for_week(weeks[8])),
            average(total_qa_for_week(weeks[9]), total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "Infrastructure",
          fillColor: "rgba(255,191,127,0.2)",
          strokeColor: "rgba(255,191,127,1)",
          pointColor: "rgba(255,191,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(255,191,127,1)",
          data: [
            average(total_infraestructure_for_week(weeks[0]), total_hours_for_week(weeks[0])),
            average(total_infraestructure_for_week(weeks[1]), total_hours_for_week(weeks[1])),
            average(total_infraestructure_for_week(weeks[2]), total_hours_for_week(weeks[2])),
            average(total_infraestructure_for_week(weeks[3]), total_hours_for_week(weeks[3])),
            average(total_infraestructure_for_week(weeks[4]), total_hours_for_week(weeks[4])),
            average(total_infraestructure_for_week(weeks[5]), total_hours_for_week(weeks[5])),
            average(total_infraestructure_for_week(weeks[6]), total_hours_for_week(weeks[6])),
            average(total_infraestructure_for_week(weeks[7]), total_hours_for_week(weeks[7])),
            average(total_infraestructure_for_week(weeks[8]), total_hours_for_week(weeks[8])),
            average(total_infraestructure_for_week(weeks[9]), total_hours_for_week(weeks[9]))
          ]
        },
        {
          label: "UI/UX",
          fillColor: "rgba(191,127,255,0.2)",
          strokeColor: "rgba(191,127,255,1)",
          pointColor: "rgba(191,127,255,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(191,127,255,1)",
          data: [
            average(total_uxui_for_week(weeks[0]), total_hours_for_week(weeks[0])),
            average(total_uxui_for_week(weeks[1]), total_hours_for_week(weeks[1])),
            average(total_uxui_for_week(weeks[2]), total_hours_for_week(weeks[2])),
            average(total_uxui_for_week(weeks[3]), total_hours_for_week(weeks[3])),
            average(total_uxui_for_week(weeks[4]), total_hours_for_week(weeks[4])),
            average(total_uxui_for_week(weeks[5]), total_hours_for_week(weeks[5])),
            average(total_uxui_for_week(weeks[6]), total_hours_for_week(weeks[6])),
            average(total_uxui_for_week(weeks[7]), total_hours_for_week(weeks[7])),
            average(total_uxui_for_week(weeks[8]), total_hours_for_week(weeks[8])),
            average(total_uxui_for_week(weeks[9]), total_hours_for_week(weeks[9]))
          ]
        }
      ]
    }
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
