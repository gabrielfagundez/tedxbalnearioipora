class ProjectRadarChart

  CHART_OPTIONS = {
    dev: {
      background_color:   "rgba(127, 255, 127, 0.2)",
      border_color:       "rgba(127, 255, 127, 1)",
      point_color:        "rgba(127, 255, 127, 1)"
    },
    bugs: {
      background_color:   "rgba(255, 127, 127, 0.2)",
      border_color:       "rgba(255, 127, 127, 1)",
      point_color:        "rgba(255, 127, 127, 1)"
    }
  }

  def initialize(project)
    @project = project
  end

  def chart_data
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
          backgroundColor:      CHART_OPTIONS[:dev][:background_color],
          borderColor:          CHART_OPTIONS[:dev][:border_color],
          pointColor:           CHART_OPTIONS[:dev][:point_color],
          data: [
            @project.total_development_for_week(weeks[0]),
            @project.total_development_for_week(weeks[1]),
            @project.total_development_for_week(weeks[2]),
            @project.total_development_for_week(weeks[3]),
          ]
        },
        {
          label: "Bugs",
          backgroundColor:      CHART_OPTIONS[:bugs][:background_color],
          borderColor:          CHART_OPTIONS[:bugs][:border_color],
          pointColor:           CHART_OPTIONS[:bugs][:point_color],
          data: [
            @project.total_bugs_for_week(weeks[0]),
            @project.total_bugs_for_week(weeks[1]),
            @project.total_bugs_for_week(weeks[2]),
            @project.total_bugs_for_week(weeks[3]),
          ]
        }
      ]
    }
  end

end
