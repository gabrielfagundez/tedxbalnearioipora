class ProjectVelocity

  def initialize(project)
    @project = project
  end

  def min_velocity(periods)
    values = @project.velocity_registers.limit(periods).collect(&:points)
    values.any? ? values.min : "-"
  end

  def max_velocity(periods)
    values = @project.velocity_registers.limit(periods).collect(&:points)
    values.any? ? values.max : "-"
  end

  def avg_velocity(periods)
    values = @project.velocity_registers.limit(periods).collect(&:points)
    values.any? ? values.inject(:+) / values.length : "-"
  end

  def next_velocity_register_date
    last_velocity_register = @project.velocity_registers.last
    last_velocity_register.present? ? last_velocity_register.end_date.strftime('%m-%d-%Y') : ""
  end

end
