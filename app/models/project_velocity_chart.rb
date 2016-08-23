class ProjectVelocityChart

  CHART_OPTIONS = {
    background_color:   "rgba(151, 187, 205, 0.5)",
    border_color:       "rgba(151, 187, 205, 0.8)",
    avg_border_color:   "rgba(66, 113, 118, 1)",
    border_width:       2,
    point_radius:       5,
    point_hover_radius: 5,
    point_hit_radius:   20
  }

  def initialize(project)
    @project = project
  end

  def chart_data
    weeks = @project.velocity_registers.order(created_at: 'desc').limit(10).collect(&:period).reverse
    values = @project.velocity_registers.order(created_at: 'desc').limit(10).collect(&:points).reverse
    avg = values.inject(:+) / values.length

    {
      labels: weeks,
      datasets: [
          {
              label:            "Average",
              backgroundColor:  "rgba(0, 0, 0, 0)",
              borderColor:      CHART_OPTIONS[:avg_border_color],
              borderWidth:      3,
              pointRadius:      0,
              pointHoverRadius: 0,
              pointHitRadius:   CHART_OPTIONS[:point_hit_radius],
              data:             [avg, avg, avg, avg, avg, avg, avg, avg, avg, avg]
          },
          {
              label:            "Points Completed",
              backgroundColor:  CHART_OPTIONS[:background_color],
              borderColor:      CHART_OPTIONS[:border_color],
              borderWidth:      CHART_OPTIONS[:border_width],
              pointRadius:      CHART_OPTIONS[:point_radius],
              pointHoverRadius: CHART_OPTIONS[:point_hover_radius],
              pointHitRadius:   CHART_OPTIONS[:point_hit_radius],
              data:             values
          }
        ]
      }
  end

end
