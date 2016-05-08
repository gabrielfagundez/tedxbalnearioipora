class ProjectVelocityChart

  CHART_OPTIONS = {
    background_color:   "rgba(151, 187, 205, 0.5)",
    border_color:       "rgba(151, 187, 205, 0.8)"
  }

  def initialize(project)
    @project = project
  end

  def chart_data
    weeks = @project.points_completed_entries.order(created_at: 'desc').limit(10).collect(&:period).reverse
    values = @project.points_completed_entries.order(created_at: 'desc').limit(10).collect(&:points_completed).reverse

    @velocity ||= {
    labels: weeks,
    datasets: [
        {
            label:            "Points Completed",
            backgroundColor:  CHART_OPTIONS[:background_color],
            borderColor:      CHART_OPTIONS[:border_color],
            data:             values
        }
      ]
    }
  end

end
