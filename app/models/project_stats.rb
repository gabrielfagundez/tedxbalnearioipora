class ProjectStats

  def initialize(project)
    @project = project
  end

  def build_stats
    {
      avg_four_weeks: average_weeks(4),
      contract_end_date: @project.contract_end_date || "~",
      expected_hours: @project.expected_hours || "~"
    }
  end

  private

  def average_weeks(weeks)
    minutes = @project.time_entries
      .between_dates(Date.today.beginning_of_week(:monday) - weeks.weeks, Date.today.beginning_of_week(:monday))
      .map(&:duration).inject(:+) || 0.0

    (minutes / (60 * 60)).round(2)
  end

end
