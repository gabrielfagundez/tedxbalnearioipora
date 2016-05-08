class ProjectTotalTimeChart

  CHART_OPTIONS = {
    background_color:   "rgba(151, 187, 205, 0.5)",
    border_color:       "rgba(151, 187, 205, 0.8)",
    border_width:       2
  }

  def initialize(project)
    @project = project
  end

  def chart_data
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
            backgroundColor:  CHART_OPTIONS[:background_color],
            borderColor:      CHART_OPTIONS[:border_color],
            borderWidth:      CHART_OPTIONS[:border_width],
            highlightFill:    "rgba(151,187,205,0.75)",
            highlightStroke:  "rgba(151,187,205,1)",
            data: [
              @project.total_hours_for_week(weeks[0]),
              @project.total_hours_for_week(weeks[1]),
              @project.total_hours_for_week(weeks[2]),
              @project.total_hours_for_week(weeks[3]),
              @project.total_hours_for_week(weeks[4]),
              @project.total_hours_for_week(weeks[5]),
              @project.total_hours_for_week(weeks[6]),
              @project.total_hours_for_week(weeks[7]),
              @project.total_hours_for_week(weeks[8]),
              @project.total_hours_for_week(weeks[9])
            ]
        }
      ]
    }
  end

end
