class ProjectTotalTimeChart

  CHART_OPTIONS = {
    background_color:   "rgba(151, 187, 205, 0.5)",
    border_color:       "rgba(151, 187, 205, 0.8)",
    border_width:       2
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
    [
      {
          label:            "Hours",
          backgroundColor:  CHART_OPTIONS[:background_color],
          borderColor:      CHART_OPTIONS[:border_color],
          borderWidth:      CHART_OPTIONS[:border_width],
          highlightFill:    "rgba(151, 187, 205, 0.75)",
          highlightStroke:  "rgba(151, 187, 205, 1)",
          data:             data
      }
    ]
  end

end
