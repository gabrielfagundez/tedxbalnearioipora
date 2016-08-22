class ProjectVelocityProgressChart

  CHART_OPTIONS = {
    background_color:   "rgba(211, 211, 211, 0.5)",
    border_color:       "rgba(211, 211, 211, 0.9)",
    border_width:       2,
    point_radius:       5,
    point_hover_radius: 5,
    point_hit_radius:   20,
    green:              "rgba(0, 166, 90, 0.8)",
    red:                "rgba(255, 0, 0, 0.8)"
  }

  def initialize(project)
    @project = project
  end

  def chart_data(months = 3)
    velocity_registers_quantity =
      @project.weekly_velocity? ? (months * 4 + 3) : (months * 2 + 3)

    periods = @project.velocity_registers.order(created_at: 'desc').limit(velocity_registers_quantity).collect(&:period).reverse
    values = @project.velocity_registers.order(created_at: 'desc').limit(velocity_registers_quantity).collect(&:points).reverse

    soften_values = []
    values.each_with_index do |register, index|
      if index >= 3
        soften_value = values[index-3..index].sum / 4.0
        soften_values.push(soften_value)
      end
    end

    labels = [periods[0].to_s]
    (soften_values.length - 2).times do |val|
      labels.push("...")
    end
    labels.push("Today")

    overall_progress_data = []
    step = (soften_values[-1] - soften_values[0]) / soften_values.length
    soften_values.each_with_index do |soften_value, index|
      overall_progress_data.push(soften_values[0] + step * index)
    end

    {
      labels: labels,
      datasets: [
        {
            label:            "Overall Progress",
            backgroundColor:  "rgba(0, 0, 0, 0)",
            borderColor:      soften_values[0] <= soften_values[-1] ? CHART_OPTIONS[:green] : CHART_OPTIONS[:red],
            borderWidth:      2,
            pointRadius:      0,
            pointHoverRadius: 0,
            pointHitRadius:   CHART_OPTIONS[:point_hit_radius],
            data:             overall_progress_data
        },
        {
            label:            "Soften Points Completed",
            backgroundColor:  CHART_OPTIONS[:background_color],
            borderColor:      CHART_OPTIONS[:border_color],
            borderWidth:      CHART_OPTIONS[:border_width],
            pointRadius:      CHART_OPTIONS[:point_radius],
            pointHoverRadius: CHART_OPTIONS[:point_hover_radius],
            pointHitRadius:   CHART_OPTIONS[:point_hit_radius],
            data:             soften_values
        }
      ]
    }
  end

  private

  def percentaje(val1, val2, val3, val4)

  end

end
