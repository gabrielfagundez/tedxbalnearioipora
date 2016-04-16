class Project < ActiveRecord::Base

  NULL_ATTRS = %w( hired_hours expected_hours contract_end_date mision vision daily_meeting retrospectives iteration_planning estimates_model issue_tracker )
  before_save :nil_if_blank

  has_many :weekly_entries
  has_many :points_completed_entries
  has_many :versions
  has_many :favourite_projects
  belongs_to :team_leader, class_name: 'TeamMember'
  belongs_to :client
  has_and_belongs_to_many :team_members

  def self.favourites
    where(favourite: true)
  end

  def stats
    @stats ||= {
      avg_four_weeks: average_four_weeks.round(1),
      remaining_weeks: hired_hours.present? ? ((hired_hours - used_hours) / average_four_weeks).round(1) : nil,
      contract_end_date: contract_end_date || "~",
      expected_hours: expected_hours.present? ? expected_hours : "~",
      this_week: { hours: self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 1.week).to_s, week: "Last week: #{(Date.today.beginning_of_week(:monday) - 1.week).to_s}" }
    }
  end

  def used_hours
    self.weekly_entries.map{ |we| we.communication + we.development + we.bugs + we.code_review + we.qa + we.infraestructure + we.uxui }.sum().to_f
  end

  def average_four_weeks
    @average_four_weeks ||=
      (self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 1.week) +
      self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 2.week) +
      self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 3.week) +
      self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 4.week)) / 4
  end

  def velocity
    weeks = points_completed_entries.order(created_at: 'desc').limit(10).collect(&:period).reverse
    values = points_completed_entries.order(created_at: 'desc').limit(10).collect(&:points_completed).reverse

    @velocity ||= {
    labels: weeks,
    datasets: [
        {
            label: "Points Completed",
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,0.8)",
            highlightFill: "rgba(151,187,205,0.75)",
            highlightStroke: "rgba(151,187,205,1)",
            data: values
        }
      ]
    }
  end

  def overview
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
            label: "Hours",
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,0.8)",
            highlightFill: "rgba(151,187,205,0.75)",
            highlightStroke: "rgba(151,187,205,1)",
            data: [
              total_hours_for_week(weeks[0]),
              total_hours_for_week(weeks[1]),
              total_hours_for_week(weeks[2]),
              total_hours_for_week(weeks[3]),
              total_hours_for_week(weeks[4]),
              total_hours_for_week(weeks[5]),
              total_hours_for_week(weeks[6]),
              total_hours_for_week(weeks[7]),
              total_hours_for_week(weeks[8]),
              total_hours_for_week(weeks[9])
            ]
        }
      ]
    }
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

  def historical
    [
      {
          value: self.weekly_entries.map{ |we| we.communication }.sum().to_f,
          color:"rgba(127,127,255,1)",
          highlight: "rgba(127,127,255,1)",
          label: "Communication"
      },
      {
          value: self.weekly_entries.map{ |we| we.development }.sum().to_f,
          color:"rgba(127,255,127,1)",
          highlight: "rgba(127,255,127,1)",
          label: "Development"
      },
      {
          value: self.weekly_entries.map{ |we| we.bugs }.sum().to_f,
          color:"rgba(255,127,127,1)",
          highlight: "rgba(255,127,127,1)",
          label: "Bugs"
      },
      {
          value: self.weekly_entries.map{ |we| we.code_review }.sum().to_f,
          color:"rgba(127,127,127,1)",
          highlight: "rgba(127,127,127,1)",
          label: "Code Review"
      },{
          value: self.weekly_entries.map{ |we| we.qa }.sum().to_f,
          color:"rgba(255,255,127,1)",
          highlight: "rgba(255,255,127,1)",
          label: "QA"
      },
      {
          value: self.weekly_entries.map{ |we| we.infraestructure }.sum().to_f,
          color:"rgba(255,191,127,1)",
          highlight: "rgba(255,191,127,1)",
          label: "Infrastructure"
      },
      {
          value: self.weekly_entries.map{ |we| we.uxui }.sum().to_f,
          color:"rgba(191,127,255,1)",
          highlight: "rgba(191,127,255,1)",
          label: "UI/UX"
      }
    ]
  end

  def radar
    weeks = [
      (Date.today.beginning_of_week(:monday) - 4.week).to_s,
      (Date.today.beginning_of_week(:monday) - 3.week).to_s,
      (Date.today.beginning_of_week(:monday) - 2.week).to_s,
      (Date.today.beginning_of_week(:monday) - 1.week).to_s
    ]

    {
      labels: [weeks[0], weeks[1], weeks[2], weeks[3]],
      datasets: [
        {
          label: "Development",
          fillColor: "rgba(127,255,127,0.2)",
          strokeColor: "rgba(127,255,127,1)",
          pointColor: "rgba(127,255,127,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(127,255,127,1)",
          data: [
            total_development_for_week(weeks[0]),
            total_development_for_week(weeks[1]),
            total_development_for_week(weeks[2]),
            total_development_for_week(weeks[3]),
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
            total_bugs_for_week(weeks[0]),
            total_bugs_for_week(weeks[1]),
            total_bugs_for_week(weeks[2]),
            total_bugs_for_week(weeks[3]),
          ]
        }
      ]
    }
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

  protected

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
