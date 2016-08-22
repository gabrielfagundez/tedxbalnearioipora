class ProjectTotalTimeChart

  CHART_OPTIONS = {
    background_color:   "rgba(151, 187, 205, 0.5)",
    border_color:       "rgba(151, 187, 205, 0.8)",
    border_width:       2,
    point_hit_radius:   20
  }

  def initialize(project, weeks = 10)
    @project = project
    @categories = @project.client.account.time_categories
    @weeks = weeks.times.map do |weeks_ago| (Date.today.beginning_of_week(:monday) - (weeks_ago + 1).weeks) end.reverse
  end

  def chart_data
    {
      labels: @weeks.map(&:to_s),
      datasets: build_datasets
    }
  end

  private

  def build_datasets
    data = @weeks.map do |start_of_week|
      time_entries = @project.time_entries.between_dates(start_of_week, start_of_week + 7.days)
      ((time_entries.map(&:duration).inject(:+) || 0.0) / (60 * 60)).round(2)
    end

    build_hash_dataset(data)
  end

  def build_hash_dataset(data)
    hash_dataset = [
      {
          label:            "Hours Billed",
          backgroundColor:  CHART_OPTIONS[:background_color],
          borderColor:      CHART_OPTIONS[:border_color],
          borderWidth:      CHART_OPTIONS[:border_width],
          highlightFill:    "rgba(151, 187, 205, 0.75)",
          highlightStroke:  "rgba(151, 187, 205, 1)",
          data:             data
      }
    ]

    hash_dataset.push(expected_hours_hash) if @project.expected_hours.present?

    hash_dataset
  end

  def expected_hours_hash
    {
        label:            "Expected Hours",
        type:             "line",
        backgroundColor:  "rgba(0, 0, 0, 0)",
        borderColor:      "rgba(255, 0, 0, 0.8)",
        borderWidth:      1,
        pointRadius:      0,
        pointHoverRadius: 0,
        pointHitRadius:   CHART_OPTIONS[:point_hit_radius],
        data:             Array.new(@weeks.length, @project.expected_hours)
    }
  end

end
