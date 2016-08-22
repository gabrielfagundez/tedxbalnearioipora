class ProjectTimeUsageChart

  CHART_OPTIONS = {
    border_width:       2,
    point_radius:       2,
    point_hover_radius: 2,
    point_hit_radius:   20
  }

  def initialize(project, weeks = 10)
    @project = project
    @categories = @project.client.account.time_categories
    @weeks = weeks.times.map do |weeks_ago| (Date.today.beginning_of_week(:monday) - (weeks_ago + 1).weeks) end.reverse
  end

  def chart_data
    {
      metadata: build_metadata,
      labels: @weeks.map(&:to_s),
      datasets: build_datasets
    }
  end

  private

  def percentaje(value, total)
    value.nil? ? 0.0 : value.to_f.send(:/, total).send(:*, 100).round(1)
  end

  def build_datasets(timespan = 7)
    @categories.map do |time_category|
      data = @weeks.map do |start_of_week|
        time_entries = @project.time_entries.between_dates(start_of_week, start_of_week + timespan.days)

        percentaje(
          time_entries.where(time_category_id: time_category.id).map(&:duration).inject(:+),
          time_entries.map(&:duration).inject(:+)
        )
      end

      build_hash_dataset(time_category, data)
    end
  end

  def build_hash_dataset(time_category, data)
    {
      label:                time_category.name,
      fill:                 true,
      backgroundColor:      time_category.rgba_color(0.2),
      borderColor:          time_category.rgba_color,
      borderWidth:          CHART_OPTIONS[:border_width],
      pointRadius:          CHART_OPTIONS[:point_radius],
      pointHoverRadius:     CHART_OPTIONS[:point_hover_radius],
      pointHitRadius:       CHART_OPTIONS[:point_hit_radius],
      data:                 data
    }
  end

  def build_metadata(start_date = Date.today.beginning_of_week(:monday) - 1.week, timespan = 7)
    time_entries = @project.time_entries.between_dates(start_date, start_date + timespan.days)
    time_values = @categories.map do |category|
      { name: category.name, time: time_entries.where(time_category_id: category.id).map(&:duration).inject(:+) || 0 }
    end

    time_values.sort_by { |k| k[:time] }

    {
      max1: {
        value: "#{time_values[0][:time]} %",
        label: time_values[0][:name],
      },
      max2: {
        value: "#{time_values[1][:time]} %",
        label: time_values[1][:name],
      },
      max3: {
        value: "#{time_values[2][:time]} %",
        label: time_values[2][:name],
      }
    }
  end

end
