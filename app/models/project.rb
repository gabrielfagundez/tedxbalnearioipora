class Project < ActiveRecord::Base

  has_many :weekly_entries
  belongs_to :client

  def self.favourites
    where(favourite: true)
  end

  def self.load_seeds
    numerex = Client.where(name: 'Numerex').first
    youscience = Client.where(name: 'YouScience').first
    semmons = Client.where(name: 'S. Emmons').first

    Project.create(client_id: numerex.id, name: 'RSC')
    Project.create(client_id: numerex.id, name: 'FastTrackFleet')
    Project.create(client_id: numerex.id, name: 'iManage')
    Project.create(client_id: numerex.id, name: 'iTank')

    Project.create(client_id: youscience.id, name: 'Web App')

    Project.create(client_id: semmons.id, name: 'YoYoBlox')
    Project.create(client_id: semmons.id, name: 'Studio Movie Grill')
  end

  def stats
    {
      three_weeks_ago: { hours: self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 3.week).to_s, week: (Date.today.beginning_of_week(:monday) - 3.week).to_s },
      two_weeks_ago: { hours: self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 2.week).to_s, week: (Date.today.beginning_of_week(:monday) - 3.week).to_s },
      one_week_ago: { hours: self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 1.week).to_s, week: (Date.today.beginning_of_week(:monday) - 3.week).to_s },
      this_week: { hours: self.total_hours_for_week(Date.today.beginning_of_week(:monday)).to_s, week: (Date.today.beginning_of_week(:monday) - 3.week).to_s }
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
      (Date.today.beginning_of_week(:monday) - 1.week).to_s,
      (Date.today.beginning_of_week(:monday)).to_s
    ]

    {
    labels: [weeks[0], weeks[1], weeks[2], weeks[3], weeks[4], weeks[5], weeks[6], weeks[7], weeks[8], weeks[9], weeks[10]],
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
              total_hours_for_week(weeks[9]),
              total_hours_for_week(weeks[10])
            ]
        }
    ]
    }
  end

  def summary
    weeks = [
      (Date.today.beginning_of_week(:monday) - 6.week).to_s,
      (Date.today.beginning_of_week(:monday) - 5.week).to_s,
      (Date.today.beginning_of_week(:monday) - 4.week).to_s,
      (Date.today.beginning_of_week(:monday) - 3.week).to_s,
      (Date.today.beginning_of_week(:monday) - 2.week).to_s,
      (Date.today.beginning_of_week(:monday) - 1.week).to_s,
      (Date.today.beginning_of_week(:monday)).to_s
    ]

    {
      labels: [weeks[0], weeks[1], weeks[2], weeks[3], weeks[4], weeks[5], weeks[6]],
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
            total_communication_for_week(weeks[0]),
            total_communication_for_week(weeks[1]),
            total_communication_for_week(weeks[2]),
            total_communication_for_week(weeks[3]),
            total_communication_for_week(weeks[4]),
            total_communication_for_week(weeks[5]),
            total_communication_for_week(weeks[6]),
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
            total_development_for_week(weeks[0]),
            total_development_for_week(weeks[1]),
            total_development_for_week(weeks[2]),
            total_development_for_week(weeks[3]),
            total_development_for_week(weeks[4]),
            total_development_for_week(weeks[5]),
            total_development_for_week(weeks[6]),
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
            total_bugs_for_week(weeks[4]),
            total_bugs_for_week(weeks[5]),
            total_bugs_for_week(weeks[6]),
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
            total_code_review_for_week(weeks[0]),
            total_code_review_for_week(weeks[1]),
            total_code_review_for_week(weeks[2]),
            total_code_review_for_week(weeks[3]),
            total_code_review_for_week(weeks[4]),
            total_code_review_for_week(weeks[5]),
            total_code_review_for_week(weeks[6]),
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
            total_qa_for_week(weeks[0]),
            total_qa_for_week(weeks[1]),
            total_qa_for_week(weeks[2]),
            total_qa_for_week(weeks[3]),
            total_qa_for_week(weeks[4]),
            total_qa_for_week(weeks[5]),
            total_qa_for_week(weeks[6]),
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
            total_infraestructure_for_week(weeks[0]),
            total_infraestructure_for_week(weeks[1]),
            total_infraestructure_for_week(weeks[2]),
            total_infraestructure_for_week(weeks[3]),
            total_infraestructure_for_week(weeks[4]),
            total_infraestructure_for_week(weeks[5]),
            total_infraestructure_for_week(weeks[6]),
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
            total_uxui_for_week(weeks[0]),
            total_uxui_for_week(weeks[1]),
            total_uxui_for_week(weeks[2]),
            total_uxui_for_week(weeks[3]),
            total_uxui_for_week(weeks[4]),
            total_uxui_for_week(weeks[5]),
            total_uxui_for_week(weeks[6]),
          ]
        }
      ]
    }
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
      (Date.today.beginning_of_week(:monday) - 3.week).to_s,
      (Date.today.beginning_of_week(:monday) - 2.week).to_s,
      (Date.today.beginning_of_week(:monday) - 1.week).to_s,
      (Date.today.beginning_of_week(:monday)).to_s
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

end
