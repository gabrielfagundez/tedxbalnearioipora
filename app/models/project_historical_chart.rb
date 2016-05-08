class ProjectHistoricalChart

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
    {
      datasets: [{
        data: [
          @project.weekly_entries.map{ |we| we.communication }.sum().to_f,
          @project.weekly_entries.map{ |we| we.development }.sum().to_f,
          @project.weekly_entries.map{ |we| we.bugs }.sum().to_f,
          @project.weekly_entries.map{ |we| we.code_review }.sum().to_f,
          @project.weekly_entries.map{ |we| we.qa }.sum().to_f,
          @project.weekly_entries.map{ |we| we.infraestructure }.sum().to_f,
          @project.weekly_entries.map{ |we| we.uxui }.sum().to_f
        ],
        backgroundColor: [
          "rgba(127,127,255,1)",
          "rgba(127,255,127,1)",
          "rgba(255,127,127,1)",
          "rgba(127,127,127,1)",
          "rgba(255,255,127,1)",
          "rgba(255,191,127,1)",
          "rgba(191,127,255,1)"
        ],
        label: 'My dataset'
      }],
      labels: [
        "Communication",
        "Development",
        "Bugs",
        "Code Review",
        "QA",
        "Infrastructure",
        "UI/UX"
      ]
    }
  end

end
